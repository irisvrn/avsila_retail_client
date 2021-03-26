//
//  ApiCaller.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 13.03.2021.
//  Copyright © 2021 Eugene Izotov. All rights reserved.
//

import Foundation

final class ApiCaller {
    static let shared = ApiCaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://dev1.avsila.ru/api/index.php"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    
    
    
    public func getDiscountCardVolume(completion: @escaping ((Result<DiscountCardVolume, Error>)-> Void)) {
        
        let devicetypeUnicode = Model.shared.devicetype.replacingOccurrences(of: "\\s",
                                                with: "%20",
                                                options: [.regularExpression])

        let phoneNumber = Model.shared.getPhone()
        
        let cardCode = "D0356568"
        
        let parametrs = "?card_code=" + cardCode + "&device_id=" + Model.shared.deviceId + "&device_type=" + devicetypeUnicode + "&token=" + Model.shared.getToken()
        
        
        
        createRequest(with: URL(string: Constants.baseAPIURL),
                      type: .POST, params: parametrs) { (request) in
            
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
//                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                     print("json \(json)")
                    let result = try JSONDecoder().decode(DiscountCardVolume.self, from: data)
                    print("discoiunt \(result.discount)")
                    print("Ok")
                   completion(.success(result))
                }
                catch {
                    print("err")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    public func getPersonalData4(completion: @escaping ((Result<PersonalDatas, Error>)-> Void)) {
        
        let devicetypeUnicode = Model.shared.devicetype.replacingOccurrences(of: "\\s",
                                                with: "%20",
                                                options: [.regularExpression])

        let phoneNumber = Model.shared.getPhone()
        guard let url = URL(string: "https://dev1.avsila.ru/api/index.php") else { return }
  //      let cardCode = "D0356568"

        let parametrs = "&device_id=" + Model.shared.deviceId + "&device_type=" + devicetypeUnicode + "&token=" + Model.shared.getToken()
        
        createRequest(with: URL(string: Constants.baseAPIURL),
                      type: .POST, params: parametrs) { (request) in
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(PersonalDatas.self, from: data)
                   completion(.success(result))
                }
                catch {
                    print("err")
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    // MARK - Private
    enum HTTPMethod:String {
        case GET
        case POST
    }
    
    private func createRequest(with url: URL?,
                               type: HTTPMethod,
                               params: String?,
                               completion: @escaping (URLRequest) -> Void) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            var request = URLRequest(url: apiURL)
            //request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            
            if type == .POST {
                let httpBody = Data(params!.utf8)
                request.httpBody = httpBody
            }
            completion(request)
        }
    }
}
