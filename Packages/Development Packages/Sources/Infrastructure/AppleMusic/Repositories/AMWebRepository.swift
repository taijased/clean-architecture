//
//  AMWebRepository.swift
//
//
//  Created by Maxim Spiridonov on 14.11.2021.
//

import Foundation
import Core
import Network

public final class AMWebRepository: INetworking, IAMWebRepository {
    // MARK: - Properties
    
    public lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }()
    
    public lazy var baseURL: String = "https://rss.applemarketingtools.com/api/v2/"

    // MARK: - Initializer
    
    public init() {}
    
    // MARK: - Functions
    
    public func fetchAll(completion: @escaping (Result<[AppleMusic], Error>) -> Void) {
        let callResult: (Result<RSSModel, APIError>) -> Void = { result in
            switch result {
            case .success(let rss):
                let musics = rss.feed.results.map{
                    AppleMusic(
                        id: $0.id,
                        name: $0.name,
                        artworkUrl100: $0.artworkUrl100,
                        url: $0.url
                    )
                }
                completion(.success(musics))
            case .failure(let error):
                print(error.errorDescription)
                completion(.failure(error))
            }
        }
        
        call(
            endpoint: API.music,
            completion: callResult
        )
    }
}

extension AMWebRepository {
    public enum API {
        //MARK: - Cases
        
        case music
    }
}

extension AMWebRepository.API: APICall {
    //MARK: - Properties
    
    public var path: String {
        switch self {
        case .music:
            return "us/music/most-played/20/albums.json"
        }
    }

    public var method: String {
        switch self {
        case .music:
            return "GET"
        }
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    //MARK: - Functions
    
    public func body() throws -> Data? {
        
        switch self {
        case .music:
            return nil
        }
    }
}

