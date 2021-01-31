//
//:MARK Что надо сделать:
//  собрать все данные которые нужны для каждого элемента чтобы понять какие API делать и как часто можно
// дописать регистрацию и вход по логину и паролю
// прикручивать realm и прикручитвать ли KeyChain для хранения аутентификации по token
// в принципе достаточно хранить картинку с ШК и код кратинки как его полчить , как загрузить и хранить в приложении. делать ли что бы протухал,
// кнопку обноивть ШК или картинку.
// при загрузке muse - грузить картинку по умолачанию и только после подгрузки, перезагружать картинку из сети

//API
//1. Аутентификация
//2. Аутентификация по SMS
//3. Загрузить карту или привязать карту, несколько экарнов по привязке карты.
//4. Гараж - список машин и список описания VIN и подгрузка из сети
//5. Список заказов - уже сделанных (с составом)
//6. Персональное предложение. Акции
//7. Почитать - новости с сайта
//8.1. посик запчастей бренды по артикулу из таблицы кроссов
//8.2. поиск по артикулу и по бренду - найденному

//  model.swift
//  realm2
//
//  Created by Admin on 16.04.2019.
//  Copyright © 2019 userer. All rights reserved.
//
//Look up all albums for Jack Johnson:
// https://itunes.apple.com/lookup?id=1093360&entity=album

/*
 "resultCount":29,
"results":[
{},
{
"wrapperType":"collection",
"collectionType":"Album",
"artistId":1093360,
"collectionId":991509751,
"amgArtistId":142116,
"artistName":"Muse",
"collectionName":"The Resistance",
"collectionCensoredName":"The Resistance",
"artistViewUrl":"https://music.apple.com/us/artist/muse/1093360?uo=4",
"collectionViewUrl":"https://music.apple.com/us/album/the-resistance/991509751?uo=4",
"artworkUrl60":"https://is5-ssl.mzstatic.com/image/thumb/Music1/v4/f5/9f/ec/f59fec5d-5ce1-f226-d7bb-3204eddb9337/source/60x60bb.jpg",
"artworkUrl100":"https://is5-ssl.mzstatic.com/image/thumb/Music1/v4/f5/9f/ec/f59fec5d-5ce1-f226-d7bb-3204eddb9337/source/100x100bb.jpg",
"collectionPrice":9.99,
"collectionExplicitness":"notExplicit",
"trackCount":11,
"copyright":"℗ 2009 Warner Music UK Limited",
"country":"USA",
"currency":"USD",
"releaseDate":"2009-09-14T07:00:00Z",
"primaryGenreName":"Alternative"
},
//поиск по атрикулу. В начале идет запрос брендов по артикулу, если их несколько, то выводятся для того чтобы пользователь выбрал какой бренд
// если один бренд то сразу идет второй запрос по бренду и артикулу. и выводятся результаты.
*/

import Foundation
import UIKit
import CryptoKit

class Model: NSObject {
    var resultAlbums: [albums] = []
    var resultImage : [UIImage] = []
    var brandFullList : [brandlist] = []
    var articles : [articlelist] = []
    var loginValue : Bool = true
    var loginType: Int = 0
    var multibrand : Bool = true
    var discountCartNumber = String()
    var discountCart: String = ""
    var BarCodeType: String = "Code39"
    //михаил
    let registerphone: String = "79056580157"
    // let deviceid: String = "8a08dca22a581b0b"
    //  let devicetype:String = "iPhone13,4%20:%20iPhone%2012%20Pro%20Max"
    let deviceId: String  = UIDevice.current.identifierForVendor!.uuidString
 
    var devicetype = UIDevice.current.name
    let token :String = "eyJhbGciOiJIUzM4NCIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyMTY1OCwiZXhwIjoxNjExMTQwOTAwfQ==.9ad4e74b7843c6162f6360b157eccb32a907b5df530517fb2444d27c06d8e16cb69f9bdb1e5c95372a16f734a0c85760"
    
    let password: String = "437751"
    let customerCode: String = "000009698"
    let customerDescr: String = "ART-АВТОСЕРВИС (ООО)"
    let customerId: String = "0f352dbd-e0de-11e8-bf31-001517990cd9"
   // let token: String = "7f72a68144bd55c71f2a066c2f9a43c2ef3240f7d1628ec43916bb1c31ceae71"
    let login: String = "tesst"
    
    
    
    
static let shared = Model()
    
    struct albums {
        var collectionName: String //new
        var artworkUrl100: String //new
        
        init(dictionary:Dictionary<String, Any>) {
            collectionName = dictionary["collectionName"] as? String ?? ""
            artworkUrl100 = dictionary["artworkUrl100"] as? String ?? ""
        }
    }
    //MARK: парсим ответ с сервера для decode

    
    struct authResponse: Codable {
        var token: String?
        var error: Bool
        var message: String?
    }
    
    
    //MARK: для парсинга через Json decode
        
    struct brandlist: Codable {
        var availability: Int
        var brand: String
        var description: String
        var images: [imagesbrand]?
        var number: String
        var numberFix: String
    }
    
    struct imagesbrand: Codable {
        var name: String?
        var order: Int?
    }
    
    struct articlelist {
        var brand: String
        var number: String
        var description: String
        var availability: Int
        var deliveryPeriod: String
        var price: Double
    
        init(dictionary:Dictionary<String, Any>) {
            brand = dictionary["brand"] as? String ?? ""
            number = dictionary["number"] as? String ?? ""
            description = dictionary["description"] as? String ?? ""
            availability = dictionary["availability"] as? Int ?? 0
            deliveryPeriod = dictionary["deliveryPeriod"] as? String ?? ""
            price = dictionary["price"] as? Double ?? 0.00
          }
    }
    
    func setSettings(switcherAdv: Bool) {
             UserDefaults.standard.set(switcherAdv, forKey: "showAdv" )
             UserDefaults.standard.synchronize()
         }
       
    func setSettingsLoginStatus(loginValue:Bool) {
        UserDefaults.standard.set(loginValue, forKey: "loginValue" )
        UserDefaults.standard.synchronize()
        self.loginValue = loginValue
    }
    
    func getSettings() -> (Bool) {//получаем настройки
        //     print("\(UserDefaults.standard.bool(forKey: "showAdv"))")
             return (UserDefaults.standard.bool(forKey: "loginValue"))
             
         }
    
    func setSettingsDiscountCartStatus(discountCart:String) {
        UserDefaults.standard.set(discountCart, forKey: "discountCart" )
        UserDefaults.standard.synchronize()
        self.discountCart = discountCart
    }
    
    func getSettingsDiscountCartStatus() -> (String) {//получаем настройки
        //     print("\(UserDefaults.standard.bool(forKey: "showAdv"))")
       // let disCart = UserDefaults.standard.string(forKey: "discountCart")
        if (UserDefaults.standard.string(forKey: "discountCart") != nil) {
            return UserDefaults.standard.string(forKey: "discountCart")!
        } else {
        return "xxxxxxxx"
        }
         }
    
    func setSettingsDiscountCartImg(discountCartImage:UIImage) {
        let dataImageJPG = discountCartImage.jpegData(compressionQuality: 1.0)
        UserDefaults().set(dataImageJPG, forKey: "discountCartImage")
      //  UserDefaults.standard.set(discountCartImage, forKey: "discountCartImage" )
       // UserDefaults.standard.synchronize()
       // self.discountCart = discountCart
    }
    
    func getSettingsDiscountCartImg() -> (UIImage) {//получаем настройки
      
        if (UserDefaults.standard.object(forKey: "discountCartImage") != nil) {
            return UIImage(data: UserDefaults.standard.object(forKey: "discountCartImage") as! Data)!
        } else {
        return UIImage()
        }
        //let data = UserDefaults.standard.object(forKey: "discountCartImage") as! Data
         }
    
    
    
    func loadJSONFileAlbums()  {
       // var strURL = "https://avsila.ru/test_index_2.php?action=download&file=products.json"
        var strURL = "https://itunes.apple.com/lookup?id=1093360&entity=album"
        
        
        let url = URL(string: strURL)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                let pathAlbum = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/albums.json"
                
                let urlForSave = URL(fileURLWithPath: pathAlbum)
                
                do{
                    try data?.write(to: urlForSave)
            
                    print("Файл загружен \(pathAlbum)")
                    self.parseJSONalbums(filepath: pathAlbum) //парсим XML сразу после загрузки
                } catch {
                    print("Error when save \(error.localizedDescription)")
                }
                
            } else {
                //  print("Error when ladXMLFile:"+error.localizedDescription)
                print("Error when ladJSONFile:\(error?.localizedDescription)")
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startLoadingJSON"), object: self)
        task.resume() //запуск УРЛ сессии
    }
    
    
    func parseJSONalbums(filepath : String) {
        //print(filepath)
        let urlPath = URL(fileURLWithPath: filepath)
        let data = try? Data(contentsOf: urlPath)
        if data != nil {
        guard let rootDictionary = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String,Any> else { return }
        
        
        let dictArray = rootDictionary["results"] as! NSArray
        
        var currentArray: [albums] = []
        resultAlbums.removeAll()
        
        for linesAlbum in dictArray {
            let album = albums(dictionary: linesAlbum as! Dictionary<String, Any>)
            if album.collectionName != "" {
                resultAlbums.append(album)
            }
            }
        }
        print("Данные обновлены")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "albumRefresh"), object: self)
       
    }
    
    func downloadImage() {
        
        for rowsAlbum in resultAlbums {
            let rowAlbum : (albums) = rowsAlbum
            let strURL = rowAlbum.artworkUrl100
            let imageURL = URL(string: strURL)
            var resImage = UIImage()
           //print(strURL)
        
            if imageURL != nil {
        URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            resImage = UIImage(data: data!)!
            self.resultImage.append(resImage)
           // resImage = UIImage(named: "vesta")!
            }.resume()
            
           
            }
        }
        
       // print(resultImage)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "imageRefresh"), object: self)
        print("Images downloaded")
    
        
    }
    
       func sendSMS(code: String) {
         
           guard let url = URL(string: "https://sms4b.ru/ws/sms.asmx/SendSMS") else { return }
           // https://sms4b.ru/ws/sms.asmx/SendSMS
           //POST /ws/sms.asmx/SendSMS HTTP/1.1
           //Host: sms4b.ru
           //Content-Type: application/x-www-form-urlencoded
           //Content-Length: length
           //
           //Login=string&Password=string&Source=string&Phone=string&Text=string
           
           var request = URLRequest(url: url)
       
           request.httpMethod = "POST"
           request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
           request.addValue("sms4b.ru", forHTTPHeaderField: "Host")
           request.addValue("107", forHTTPHeaderField: "Content-Length")
           
           let parametrs = "Login=avtosila&Password=silaavto&Source=Avtosila&Phone=89056580157&Text=\(code)"
           let httpBody = Data(parametrs.utf8)
           
         //  guard let httpBody = try? JSONSerialization.data(withJSONObject: parametrs, options: []) else { return }
    //       guard let httpBody = try? JSONSerialization.jsonObject(with: parametrs, options: []) as? [String:AnyObject]  else { return }
             
           request.httpBody = httpBody
           
           let session = URLSession.shared
           // отправляем на сервер
           session.dataTask(with: request) { (data, response, error) in
               if let response = response {
                   print("RESPONSE \(response)")
               } else {
                   print("ERROR !!- \(error?.localizedDescription)")
               }
           }.resume()
           
           print("Send sms to Server")
       }
    
    func phoneRegister2(phoneNumber:String) {
        //регистрация клиента
        //register=y&register_phone=79304206601&device_id=8a08dca22a581b0b&device_type=iPhone13,4 : iPhone 12 Pro Max
        
        let devicetypeUnicode = devicetype.replacingOccurrences(of: "\\s",
                                                with: "%20",
                                                options: [.regularExpression])
        
        let dataToToket: String = deviceId + devicetypeUnicode
        
        let paramString = "register=y&register_phone=" + phoneNumber + "&device_id=" + deviceId + "&device_type=" + devicetypeUnicode
        
        let urlString :String = "https://dev1.avsila.ru/api/index.php?" + paramString
        
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    
    func phoneRegister3(phoneNumber:String) {
        //регистрация через POST
      
        let devicetypeUnicode = devicetype.replacingOccurrences(of: "\\s",
                                                with: "%20",
                                                options: [.regularExpression])
        
        let dataToToket: String = deviceId + devicetypeUnicode
    
/*
        guard let url = URL(string: "https://dev1.avsila.ru/api/index.php") else { return }
        // https://sms4b.ru/ws/sms.asmx/SendSMS
        //POST /ws/sms.asmx/SendSMS HTTP/1.1
        //Host: sms4b.ru
        //Content-Type: application/x-www-form-urlencoded
        //Content-Length: length
        //
        //Login=string&Password=string&Source=string&Phone=string&Text=string
        
        var request = URLRequest(url: url)
    
        request.httpMethod = "POST"
    //    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
       // request.addValue("sms4b.ru", forHTTPHeaderField: "Host")
       // request.addValue("107", forHTTPHeaderField: "Content-Length")
        
        let parametrs = "register=y&register_phone=" + phoneNumber + "&device_id=" + deviceId + "&device_type=" + devicetypeUnicode
        let httpBody = Data(parametrs.utf8)
    
          
        request.httpBody = httpBody
        
        let session = URLSession.shared
   
        //старая версия
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print("RESPONSE \(response)")
                    //print("data: \(data!)") //данные есть надо разобрать
                print(String(data: data!, encoding: .utf8)!)
            } else {
                print("ERROR !!- \(error?.localizedDescription)")
            }
        }.resume()*/
        
        let paramString = "register=y&register_phone=" + phoneNumber + "&device_id=" + deviceId + "&device_type=" + devicetypeUnicode
        
        let urlString :String = "https://dev1.avsila.ru/api/index.php?" + paramString
        print(urlString)
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        let postString = "postDataKey=value"
        request.httpBody = postString.data(using: .utf8)
        
        
        
        guard let url = URL(string: urlString) else {return}
                  
                  let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    
                      if error == nil {
                        if data != nil {
                            print("!!!!")
                            print(String(data: data!, encoding: .utf8)!)
                            print("!!!!")
                               do {
    
                                let jsonResult = try JSONDecoder().decode(authResponse.self, from:data!)
                                
                                print("Токен:  \(jsonResult.token) \n Ошибка: \(jsonResult.error) \n Сообщение : \(jsonResult.message)")
                               } catch {
                                 //  print("Error ! \(error.localizedDescription)")
                                print("Error ! \(error)")
                               }
                           }
                      } else {
                          print("Error when getJSON:\(error?.localizedDescription)")
                      }
                  }
        task.resume()
        
        print("отправили запрос на сервер")
        
    }
    
    func phoneCheckCode2(phoneNumber:String, codeNumber:String) {
        //регистрация клиента
        //checkCode=2102&phone=79304206601&device_id=8a08dca22a581b0b&device_type=iPhone13,4 : iPhone 12 Pro Max
        
        let devicetypeUnicode = devicetype.replacingOccurrences(of: "\\s",
                                                with: "%20",
                                                options: [.regularExpression])
        
        let dataToToket: String = deviceId + devicetypeUnicode
        
        let paramString = "checkCode=" + codeNumber + "&phone=" + phoneNumber + "&device_id=" + deviceId + "&device_type=" + devicetypeUnicode
        
        let urlString :String = "https://dev1.avsila.ru/api/index.php?" + paramString
        
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    
    
    
    func phoneAuth2() {
       /* let registerphone: String = "79304206601"
        let deviceid: String = "8a08dca22a581b0b"
        let devicetype:String = "iPhone13,4 : iPhone 12 Pro Max"
        let token :String = "eyJhbGciOiJIUzM4NCIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyMTY1OCwiZXhwIjoxNjExMTQwOTAwfQ==.9ad4e74b7843c6162f6360b157eccb32a907b5df530517fb2444d27c06d8e16cb69f9bdb1e5c95372a16f734a0c85760"
    */
        
        //devicetype переводим в Unicode
      //  var dataenc = devicetype.data(using: String.Encoding.nonLossyASCII)
      //  var devicetypeUnicode: String = String(data: dataenc!, encoding: String.Encoding.utf8)!
        
        //let str = String(UTF8String: devicetype.cStringUsingEncoding(​NSUTF8StringEncoding))
       // let str = String(UTF8String: devicetype.cStringUsingEncoding(.utf8))
        
        //let str = String(utf8String: devicetype.cString(using: .utf8))
        
        
      //регулярное выражение
        let devicetypeUnicode = devicetype.replacingOccurrences(of: "\\s",
                                                with: "%20",
                                                options: [.regularExpression])
        
        let dataToToket: String = deviceId + devicetypeUnicode
        guard let data = dataToToket.data(using: .utf8) else { return }
            let digest = SHA384.hash(data: data)
        
          ///  print(digest.data) // 64 bytes
        print(digest.map { String(format: "%02X", $0) }.joined())
        
        
        let paramString = "/api/index.php?" + "phone=" + registerphone + "&device_id=" + deviceId + "&device_type=" + devicetypeUnicode + "&token=" + token
        //https://dev1.avsila.ru/api/index.php?phone=79304206601&device_id=8a08dca22a581b0b&device_type=iPhone13,4%20:%20iPhone%2012%20Pro%20Max&token=eyJhbGciOiJIUzM4NCIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoyMTY1OCwiZXhwIjoxNjExMTQwOTAwfQ==.9ad4e74b7843c6162f6360b157eccb32a907b5df530517fb2444d27c06d8e16cb69f9bdb1e5c95372a16f734a0c85760
        
        
        let urlString :String = "https://dev1.avsila.ru" + paramString
       
        print(urlString)
        
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
    
    
    func phoneAuth(code: Int) {
        print(code)
        let url = URL(string: "https://dev1.avsila.ru")!
        switch code {
        case 1:
            print("1!")
            let url = URL(string: "https://dev1.avsila.ru/api/index.php?phone=79304206603")!
        case 2:
            print("2!")
            let url = URL(string: "https://dev1.avsila.ru/api/index.php?orders=y")!
        default:
            print("3!")
            let url = URL(string: "https://dev1.avsila.ru/api/index.php?logout=y")!
        }
    
        /*
        https://dev1.avsila.ru/api/index.php?phone=79304206601 , параметр только phone , авторизация происходит если есть номер телефона в этой таблице https://dev1.avsila.ru/bitrix/admin/perfmon_table.php?lang=ru&table_name=b_user_phone_auth
        Регистрация
        https://dev1.avsila.ru/api/index.php?register=y&register_phone=79304206603
        */
        
        /////----------
        
        //let url = URL(string: "https://dev1.avsila.ru/api/index.php?phone=79304206601&orders=y")!
     
        
         //let url = URL(string: "https://dev1.avsila.ru/api/index.php?phone=79304206603")! // залогиниться//
        //let url = URL(string: "https://dev1.avsila.ru/api/index.php?orders=y")! // -статус
      //  let url = URL(string: "https://dev1.avsila.ru/api/index.php?logout=y")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
        
        ///-------
        
        /*
        var strURL = "https://dev1.avsila.ru/api/index.php?phone=79304206601"
        
        let url = URL(string: strURL)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/auth.json"
                
                let urlForSave = URL(fileURLWithPath: path)
                
                do{
                    try data?.write(to: urlForSave)
                    //print(path)
                    print("Файл загружен")
                    //self.parseJSON() //парсим XML сразу после загрузки
                } catch {
                    print("Error when save \(error.localizedDescription)")
                }
                
            } else {
                //  print("Error when ladXMLFile:"+error.localizedDescription)
                print("Error when ladJSONFile:\(error?.localizedDescription)")
            }
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "startLoadingJSON"), object: self)
        task.resume() //запуск УРЛ сессии
        
        */
      //  guard let url = URL(string: "https://dev1.avsila.ru/api/index.php?phone=79304206601") else { return }
        // https://sms4b.ru/ws/sms.asmx/SendSMS
        //POST /ws/sms.asmx/SendSMS HTTP/1.1
        //Host: sms4b.ru
        //Content-Type: application/x-www-form-urlencoded
        //Content-Length: length
        //
        //Login=string&Password=string&Source=string&Phone=string&Text=string
        
        //   var request = URLRequest(url: url)
    
    /*
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("sms4b.ru", forHTTPHeaderField: "Host")
        request.addValue("107", forHTTPHeaderField: "Content-Length")
        */
     //   let parametrs = "Login=avtosila&Password=silaavto&Source=Avtosila&Phone=89056580157&Text=\(code)"
      //  let httpBody = Data(parametrs.utf8)
        
      //  guard let httpBody = try? JSONSerialization.data(withJSONObject: parametrs, options: []) else { return }
 //       guard let httpBody = try? JSONSerialization.jsonObject(with: parametrs, options: []) as? [String:AnyObject]  else { return }
          
       // request.httpBody = httpBody
        /*
        let session = URLSession.shared
        // отправляем на сервер
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print("RESPONSE \(response)")
            } else {
                print("ERROR !!- \(error?.localizedDescription)")
            }
        }.resume()
        
        print("!-!-!")*/
    }
    
    
    func getBrandsViaArticle(code: String) {
         //MARK: новая версия парсинга JSON без сохранения файла и с decode (смотри struct) бренды по артикулу
        var strURL = "http://avtosila-vrn.ru.public.api.abcp.ru/search/brands/?userlogin=ied@avtosila-v.ru&userpsw=01b9c6e65cff3f0c4b39bc1cb9595111&number=" + code
        
        guard let url = URL(string: strURL) else {return}
                  
                  let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                      
                      if error == nil {
                        if data != nil {
                               
                               do {
    
                                   let jsonResult = try JSONDecoder().decode([String : brandlist].self, from:data!)
                                   
                                   if jsonResult.count == 1 {
                                    self.multibrand = false
                                    self.getOffer(brand: (jsonResult.first?.value.brand)!, code: code)
                                    } else {
                                    self.multibrand = true
                                   
                                       for rt in jsonResult {
                                           print(rt.value.brand)
                                           let brandRow = brandlist(availability: rt.value.availability, brand: rt.value.brand, description: rt.value.description, images: rt.value.images, number: rt.value.number, numberFix: rt.value.numberFix)
                                        self.brandFullList.append(brandRow)
                                       }
                                    
                                       NotificationCenter.default.post(name: NSNotification.Name(rawValue: "offerRefresh"), object: self)
                                    }
                                   print("кол-во брендов \(jsonResult.count)")
                               } catch {
                                   print("Error \(error.localizedDescription)")
                               }
                           }
                      } else {
                          print("Error when getJSON:\(error?.localizedDescription)")
                      }
                  }
        task.resume()
        
           print("get brands")
       }
    
    
    func getOffer(brand: String, code: String) {

        var strURL = "http://avtosila-vrn.ru.public.api.abcp.ru/search/articles/?userlogin=ied@avtosila-v.ru&userpsw=01b9c6e65cff3f0c4b39bc1cb9595111&number=" + code + "&brand=" + brand
        
                  print(strURL)
                  let url = URL(string: strURL)
                  
                  let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                      
                      if error == nil {
                        
                       // print(data)
                        
                        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] + "/offer.json"
                          
                          let urlForSaveBrand = URL(fileURLWithPath: path)
                          
                        
                          do{
                              try data?.write(to: urlForSaveBrand)
                            //  print(path)
                              print("Файл Offer загружен")
                             self.parseJSONoffer(filepath: path)
                              //self.parseJSON() //парсим XML сразу после загрузки
                          } catch {
                              print("Error when save \(error.localizedDescription)")
                          }
                          
                      } else {
                          //  print("Error when ladXMLFile:"+error.localizedDescription)
                          print("Error when getJSON:\(error?.localizedDescription)")
                      }
                  }
        task.resume()
          
       }
    
    func parseJSONoffer(filepath : String) {
        print(filepath)
        let urlPath = URL(fileURLWithPath: filepath)
        let data = try? Data(contentsOf: urlPath)
        print("парсим Offer")
        if data != nil {
            guard let rootDictionary = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [Dictionary<String,Any>] else {
                print("Ничего не найдено ОШИБКА")
                articles.removeAll()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "offerRefresh"), object: self)
                return }
            
            print("кол-во \(rootDictionary.count)")
           // print(rootDictionary)
            
            articles.removeAll()
            for lines in rootDictionary {
              let article = articlelist(dictionary: lines as! Dictionary<String, Any>)
                articles.append(article)
            }

           // print(articles)
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "offerRefresh"), object: self)
   
        }
       
    }
}

