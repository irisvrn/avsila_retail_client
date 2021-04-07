//
//  ApiCaller.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 13.03.2021.
//  Copyright © 2021 Eugene Izotov. All rights reserved.
//

import Foundation
import UIKit


final class ApiCaller {
    
    var devicetype = UIDevice.current.name
    let deviceId: String  = UIDevice.current.identifierForVendor!.uuidString
    //замещаем пробелы в названии модели телефона
    let devicetypeUnicode:String = UIDevice.current.name.replacingOccurrences(of: "\\s",
                                            with: "%20",
                                            options: [.regularExpression])
    
    static let shared = ApiCaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://dev1.avsila.ru/api/index.php"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    
    
    //MARK: - запрос регистрации по номеру телефона
    func phoneRegister3(phoneNumber:String, completion: @escaping ((Result<authResponse, Error>) -> Void) ) {
        
        //регистрация клиента через POST
        //регистрация клиента
        //register=y&register_phone=79304206601&device_id=8a08dca22a581b0b&device_type=iPhone13,4 : iPhone 12 Pro Max
        
        let dataToToket: String = deviceId + devicetypeUnicode
        
        guard let url = URL(string: "https://dev1.avsila.ru/api/index.php") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parametrs = "register=y&register_phone=" + phoneNumber + "&device_id=" + Model.shared.deviceId + "&device_type=" + devicetypeUnicode
        let httpBody = Data(parametrs.utf8)
        request.httpBody = httpBody
        
                  
                  let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                        guard let data = data, error == nil else {
                            completion(.failure(APIError.failedToGetData))
                            return
                        }
                    
                               do {
                                let result = try JSONDecoder().decode(authResponse.self, from:data)
                                completion(.success(result))
                             //   self.setToken(token: jsonResult.token!)
                             //token пришел пустой
                               } catch {
                                 
                                completion(.failure(error))
                               }
                           }
                    task.resume()
    }
    
    //MARK: - отправка кода подтверждения пришедшего по СМС и по номеру телефона
    func phoneCheckCode3(phoneNumber:String, codeNumber:String, completion: @escaping ((Result<authResponse, Error>) -> Void))  {
        var status = Int()
        //отправка кода в ответ на смсчерез POST
        //register=y&register_phone=79304206601&device_id=8a08dca22a581b0b&device_type=iPhone13,4 : iPhone 12 Pro Max
        
        let dataToToket: String = deviceId + devicetypeUnicode
    
        guard let url = URL(string: "https://dev1.avsila.ru/api/index.php") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parametrs = "checkCode=" + codeNumber + "&phone=" + phoneNumber + "&device_id=" + deviceId + "&device_type=" + devicetypeUnicode
       // print("https://dev1.avsila.ru/api/index.php?\(parametrs)")
        let httpBody = Data(parametrs.utf8)
        request.httpBody = httpBody
        
                    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                        guard let data = data, error == nil else {
                            completion(.failure(APIError.failedToGetData))
                            return
                        }
    
                        do {
                           // print(String(data: data, encoding: .utf8)!)
//                            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                            print (json)
                            let result = try JSONDecoder().decode(authResponse.self, from:data)
                            completion(.success(result))
                            
                        } catch {
                            completion(.failure(error))
                           // status = 0
                        }
                    }
                    task.resume()
    //    print("status in model 2 \(status)")
    }
    
    //MARK:- привязать карту клиента
    
    func insertCardToProfile(cardCode: String, completion: @escaping ((Result<String, Error>) -> Void) ) {
        
       // let dataToToket: String = deviceId + devicetypeUnicode
        let phoneNumber:String = Model.shared.getPhone()
        
        guard let url = URL(string: "https://dev1.avsila.ru/api/index.php") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parametrs = "set_loyality_card=y&card_code=\(cardCode)&phone=" + phoneNumber + "&device_id=" + Model.shared.deviceId + "&device_type=" + devicetypeUnicode
        print("https://dev1.avsila.ru/api/index.php?\(parametrs)")
        let httpBody = Data(parametrs.utf8)
        request.httpBody = httpBody
        
                  let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                        guard let data = data, error == nil else {
                            completion(.failure(APIError.failedToGetData))
                            return
                        }
                    
                               do {
                                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                                print (json)
//                                let result = try JSONDecoder().decode(authResponse.self, from:data)
//                                completion(.success(result))
                             //   self.setToken(token: jsonResult.token!)
                             //token пришел пустой
                               } catch {
                                 
                                completion(.failure(error))
                               }
                           }
                    task.resume()
    }
    
    
    public func getDiscountCardVolume(completion: @escaping ((Result<DiscountCardVolume, Error>)-> Void)) {
        
        let devicetypeUnicode = Model.shared.devicetype.replacingOccurrences(of: "\\s",
                                                with: "%20",
                                                options: [.regularExpression])

        let phoneNumber = Model.shared.getPhone()
        
         let cardCode = "D0356568"
        
        let parametrs = "?card_code=" + cardCode + "&device_id=" + Model.shared.deviceId + "&device_type=" + devicetypeUnicode + "&token=" + Model.shared.getToken()

 //       let parametrs = "?loyality_card=y" + "&device_id=" + Model.shared.deviceId + "&device_type=" + devicetypeUnicode + "&token=" + Model.shared.getToken()

        
 
        createRequest(with: URL(string: Constants.baseAPIURL),
                      type: .POST, params: parametrs) { (request) in
            
            let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                     print("json - \(json)")
//                    let result = try JSONDecoder().decode(DiscountCardVolume.self, from: data)
//                    print("discount \(result.discount)")
//                    print("Ok")
//                   completion(.success(result))
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
