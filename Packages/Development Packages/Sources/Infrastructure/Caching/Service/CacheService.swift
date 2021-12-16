//
//  CacheService.swift
//  
//
//  Created by Maxim Spiridonov on 12.12.2021.
//

import CoreData

public final class CacheService: DatabaseStorable {
    
    // MARK: - Constants
    
    private enum Constants {
        static let batchSize: Int = 50
    }
    
    // MARK: - Properties
    
    private let manager: CacheStack
    
    // MARK: - Initializer
    
    public init(manager: CacheStack = .default) {
        self.manager = manager
    }
    
    // MARK: - Fetchable
    
    public func fetch<Entity>(
        sort: [NSSortDescriptor]?,
        predicate: NSPredicate?,
        fetchLimit: Int?,
        _ completion: @escaping (Result<[Entity], Error>) -> Void
    ) where Entity : Cacheable {
        fetch(
            sort: sort,
            predicate: predicate,
            relatedPaths: nil,
            fetchLimit: fetchLimit,
            completion
        )
    }
    
    public func fetch<Entity>(
        sort: [NSSortDescriptor]?,
        predicate: NSPredicate?,
        relatedPaths: [String]?,
        fetchLimit: Int?,
        _ completion: @escaping (Result<[Entity], Error>) -> Void
    ) where Entity : Cacheable {
        let request: NSFetchRequest = Entity.ManagedObject.fetchRequest()
        request.fetchBatchSize = Constants.batchSize
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        request.relationshipKeyPathsForPrefetching = relatedPaths
        
        if let fetchLimit = fetchLimit {
            request.fetchLimit = fetchLimit
        }
        
        manager.mainContext.perform { [manager] in
            do {
                guard try manager.mainContext.count(for: request) > 0 else {
                    completion(.failure(CacheServiceErrors.dataNotFound))
                    return
                }
                
                guard let result = try manager.mainContext.fetch(request) as? [Entity.ManagedObject] else {
                    completion(.failure(CacheServiceErrors.deformedData))
                    return
                }
                
                let items: [Entity] = result.compactMap { $0.toEntity() as? Entity }
                completion(.success(items))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    public func isEntityExists(
        for request: NSFetchRequest<NSFetchRequestResult>,
        _ completion: @escaping (Result<Bool, Error>) -> Void
    ) {
        manager.mainContext.perform { [weak self] in
            guard let manager = self?.manager else {
                completion(.failure(CacheServiceErrors.dataNotFound))
                return
            }
            
            do {
                let count: Int = try manager.mainContext.count(for: request)
                completion(.success(count > .zero))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Updateable
    
    public func insert<Entity>(
        _ item: Entity,
        _ completion: @escaping (Result<Any, Error>) -> Void
    ) where Entity : Cacheable {
        insert([item], completion)
    }
    
    public func insert<Entity>(
        _ items: [Entity],
        _ completion: @escaping (Result<Any, Error>) -> Void
    ) where Entity : Cacheable {
        manager.persistentContainer.performBackgroundTask { [weak self] context in
            defer {
                context.reset()
            }
            
            guard let self = self else {
                completion(.success(true))
                return
            }
            
            let managedObjects: [Entity.ManagedObject] = items.compactMap { $0.toManagedObject(in: context) }
            
            guard context.hasChanges else {
                DispatchQueue.main.async {
                    completion(.success(true))
                }
                return
            }
            
            do {
                try context.save()
                self.manager.save()
                
                completion(.success(true))
            } catch {
                managedObjects.forEach { obj in
                    context.delete(obj)
                }
                
                completion(.failure(error))
            }
        }
    }
    
    public func update<Entity>(
        _ item: Entity, predicate: NSPredicate,
        _ completion: @escaping (Result<Any, Error>) -> Void
    ) where Entity : Cacheable {
        let request: NSFetchRequest = Entity.ManagedObject.fetchRequest()
        request.fetchBatchSize = Constants.batchSize
        request.fetchLimit = 1
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        
        do {
            guard try manager.mainContext.count(for: request) > 0 else {
                insert(item, completion)
                return
            }
            
            manager.mainContext.performAndWait { [weak self] in
                do {
                    guard
                        let result = try self?.manager.mainContext.fetch(request) as? [Entity.ManagedObject],
                        let resultMO = result.first
                    else {
                        completion(.failure(CacheServiceErrors
                                                .dataNotFound))
                        return
                    }
                    
                    item.updateManagedObject(resultMO)
                    
                    guard self?.manager.mainContext.hasChanges == true else {
                        completion(.success(true))
                        return
                    }
                    
                    try self?.manager.mainContext.save()
                    completion(.success(true))
                } catch {
                    completion(.failure(error))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    // MARK: - Deleteable
    
    public func deleteBy(
        by request: NSFetchRequest<NSFetchRequestResult>,
        _ completion: @escaping (Result<Any, Error>) -> Void
    ) {
        let batchRequest = NSBatchDeleteRequest(fetchRequest: request)
        batchRequest.resultType = .resultTypeObjectIDs
        
        manager.mainContext.performAndWait { [weak self] in
            do {
                guard
                    let manager = self?.manager,
                    let deleteResult = try manager.mainContext.execute(batchRequest) as? NSBatchDeleteResult,
                    let objectIDs = deleteResult.result as? [NSManagedObjectID]
                else {
                    completion(.success(true))
                    return
                }
                
                let changes: [AnyHashable: Any] = [
                    NSDeletedObjectsKey: objectIDs
                ]
                
                NSManagedObjectContext.mergeChanges(
                    fromRemoteContextSave: changes,
                    into: [manager.mainContext]
                )
                
                manager.save()
                completion(.success(true))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    public func deleteAll(
        for requests: [NSFetchRequest<NSFetchRequestResult>],
        _ completion: @escaping (Result<Any, Error>) -> Void
    ) {
        manager.mainContext.performAndWait { [weak self] in
            guard let manager = self?.manager else {
                completion(.failure(CacheServiceErrors.undefinded))
                return
            }
            
            requests.forEach {
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: $0)
                do {
                    try manager.mainContext.execute(deleteRequest)
                } catch {
                    completion(.failure(error))
                }
            }
            
            manager.save()
            completion(.success(true))
        }
    }
    
    public func deleteBy(_ objectId: NSManagedObjectID) {
        let deletedMO = manager.mainContext.object(with: objectId)
        manager.mainContext.performAndWait { [weak self] in
            self?.manager.mainContext.delete(deletedMO)
            self?.manager.save()
        }
    }
    
    public func deleteAll(
        by request: NSFetchRequest<NSFetchRequestResult>,
        _ completion: @escaping (Result<Any, Error>) -> Void
    ) {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        manager.mainContext.performAndWait { [weak self] in
            do {
                try self?.manager.mainContext.execute(deleteRequest)
                self?.manager.save()
                completion(.success(true))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

