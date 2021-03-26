//
//  AuthManager.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 13.03.2021.
//  Copyright © 2021 Eugene Izotov. All rights reserved.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private var refreshingToken = false
    
//    struct Constants {
//        static let clientID = "c3e7a23ec3b64ee6a40cb7073c76fc05"
//        static let clientSecret = "23b86eac13a8406486e13e0b1e728757"
//        static let tokenAPIURL = "https://accounts.spotify.com/api/token"
//        static let redirectURI = "https://iris-vrn.ru"
//        static let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
//    }
    
    private init() {}
    
    public func withValidToken(completion: @escaping (String) -> Void) {
//        guard !refreshingToken else {
//            //Append the copletion
//            onRefreshBlocks.append(completion)
//            return
//        }
        
//        if shouldRefreshToken {
//            // Refresh
//            refreshIfNeeded { [weak self] success in
//                    if let token = self?.accessToken, success {
//                        completion(token)
//                    }
//            }
//        } else if let token = accessToken {
//            completion(token)
//        }
        completion(Model.shared.getToken())
    }
}
