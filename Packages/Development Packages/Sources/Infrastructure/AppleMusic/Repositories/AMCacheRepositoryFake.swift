//
//  AMCacheRepositoryFake.swift
//  
//
//  Created by Maxim Spiridonov on 12.12.2021.
//

import Foundation
import Core

public final class AMCacheRepositoryFake: IAMCacheRepository {
    // MARK: - Initializer
    
    public init() {}
    
    // MARK: - Functions
    
    public func getAll(completion: @escaping (Result<[AppleMusic], Error>) -> Void) {
        let result = [
            AppleMusic(
                id: "1590368448",
                name: "Red (Taylor’s Version)(Cache)",
                artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Music115/v4/15/38/9b/15389bf4-8074-06c3-11ee-655b5453af68/21UM1IM25046.rgb.jpg/100x100bb.jpg",
                url: "https://music.apple.com/us/album/red-taylors-version-a-message-from-taylor/1590368448"
            ),
            AppleMusic(
                id: "1590029262",
                name: "Still Over It(Cache)",
                artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music126/v4/f0/8c/bf/f08cbffc-1101-f974-a2d3-38381d8ed506/21UM1IM23130.rgb.jpg/100x100bb.jpg",
                url: "https://music.apple.com/us/album/still-over-it/1590029262"
            )
        ]
        
        completion(.success(result))
    }
    
    public func add(
        items: [AppleMusic],
        completion: @escaping (Result<Any, Error>) -> Void
    ) {
        
        completion(.success(true))
    }
}
