//
//  CacheStack.swift
//  
//
//  Created by Maxim Spiridonov on 12.12.2021.
//

import CoreData

public final class CacheStack {
    // MARK: - Constants
    
    public enum Constants {
        public static let modelName: String = "Caching"
    }
    
    // MARK: - Properties
    
    public static let `default`: CacheStack = .init()
    
    public var isInitialized: Bool {
        persistentContainer != nil && !persistentContainer.persistentStoreDescriptions.isEmpty
    }
    
    public var mainContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    public var backgroundContext: NSManagedObjectContext {
        let context: NSManagedObjectContext = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.undoManager = nil
        return context
    }
    
    private(set) var persistentContainer: CachePersistentContainer!
    
    // MARK: - Initializer
    
    private init() {
        guard !isInitialized else {
            return
        }
        
        
        guard let modelPath = Bundle.module.url(
            forResource: Constants.modelName,
            withExtension: "momd"
        ) else {
            fatalError("CacheService: - Failed to find data model")
        }

        guard let objectModel = NSManagedObjectModel(contentsOf: modelPath) else {
            fatalError("CacheService: - Can't load model by path \(modelPath)")
        }
        
        let persistentDescription = NSPersistentStoreDescription()
        persistentDescription.shouldMigrateStoreAutomatically = true
        persistentDescription.shouldInferMappingModelAutomatically = true
        
        persistentContainer = CachePersistentContainer(
            name: Constants.modelName,
            managedObjectModel: objectModel
        )
        persistentContainer.persistentStoreDescriptions.append(persistentDescription)
        persistentContainer.loadPersistentStores { (_, error) in
            guard error == nil else {
                fatalError("CacheService: - Can't load persistent store")
            }
        }
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        persistentContainer.viewContext.undoManager = nil
        persistentContainer.viewContext.shouldDeleteInaccessibleFaults = true

        ValueTransformer.setValueTransformer(
            DateValueTransformer(),
            forName: NSValueTransformerName("DateValueTransformer")
        )
    }
    
    // MARK: - Methods
    
    public func save() {
        guard mainContext.hasChanges else {
            return
        }
        
        mainContext.perform { [weak self] in
            do {
                try self?.mainContext.save()
            } catch {
                #if DEBUG
                print("Failed to save in main context")
                #endif
            }
        }
    }
    
    public func resetContext() {
        mainContext.refreshAllObjects()
        mainContext.reset()
    }
    
    public func resetAllData() {
        let escapeList: [String] = [
            // Escaping models
        ]
        
        persistentContainer.managedObjectModel.entities.forEach {
            guard
                let name = $0.name,
                !escapeList.contains(name)
            else {
                return
            }
                    
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = .init(entityName: name)
            let deleteRequest: NSBatchDeleteRequest = .init(fetchRequest: fetchRequest)
            
            do {
                try mainContext.execute(deleteRequest)
            } catch {
                #if DEBUG
                print("Failed deleted alll data for entity")
                #endif
            }
        }
        
        save()
        resetContext()
    }
}
