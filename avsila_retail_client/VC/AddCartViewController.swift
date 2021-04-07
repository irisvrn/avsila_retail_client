//
//  AddCartViewController.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 09.12.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit

class AddCartViewController: UIViewController {

    var filter:CIFilter!
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
      /*  label.text = "Привяжите дисконтную карту и используйте ее на кассах в магазине или в интернет магазине. Также карта предоставляет скидку на СТО Автосила. Карта обычно имеет вид D0293902. Более подробную информацию можно получить на сайте www.avsila.ru/mobile \n если пользователь залогинен у нас задача только привзяать карту к его данным , максимум сверить с номерами телефона. \n Если пользователь на залогинен, то должны должны предложить ему войти в систему или войти через SMS. в этом случае создаем ему учетку, но предлагем выбрать уже из тех, которые нашли, если он делал заказы."*/
        label.text = "Привяжите дисконтную карту и используйте ее на кассах в магазине или в интернет магазине. Также карта предоставляет скидку на СТО Автосила. Карта обычно имеет вид D0293902. \n Более подробную информацию можно получить на сайте www.avsila.ru/mobile "
        
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let textFieldCartNumber: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите номер дисконтной карты"
        textField.returnKeyType = .continue
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 5
        textField.isSecureTextEntry = false
        textField.backgroundColor = .secondarySystemBackground
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.secondaryLabel.cgColor
        
        
        return textField
    }()
    
    private let buttonPhotoCartNamber : UIButton = {
        let button = UIButton()
        button.setTitle("Фото карты", for: .normal)
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.setTitleColor(.systemBlue, for: .normal)
       // button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapCameraBarCode), for: .touchUpInside)
        return button
    }()
    
    private let buttonNext : UIButton = {
        let button = UIButton()
        button.setTitle("Далее", for: .normal)
        //button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 5
        //button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
       // button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        return button
    }()
    
    private let buttonaBackToFirstScreen: UIButton = {
           let button = UIButton()
           button.setTitle("Назад", for: .normal)
           button.tintColor = .systemBlue
           button.layer.cornerRadius = 5
           button.backgroundColor = .systemBlue
           button.addTarget(self, action: #selector(didTapBackToFirstScreen), for: .touchUpInside)
           return button
       }()
    
    private let buttonGenerateBarCode: UIButton = {
        let button = UIButton()
        button.setTitle("Показать штрих-код", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setImage(UIImage(systemName: "barcode"), for: .normal)
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        //button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapGenerateBarCode), for: .touchUpInside)
        return button
       }()
    
    private let buttonRequestData: UIButton = {
        let button = UIButton()
        button.setTitle("Запрос", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        //button.setImage(UIImage(systemName: "barcode"), for: .normal)
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        //button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapRequestData), for: .touchUpInside)
        return button
       }()
    
    private let buttonRequestDataInsert: UIButton = {
        let button = UIButton()
        button.setTitle("Привязать карту", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        //button.setImage(UIImage(systemName: "barcode"), for: .normal)
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        //button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapRequestDataInsert), for: .touchUpInside)
        return button
       }()
    
    private let switchBarCodeTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Code128/Code39"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    private let switchBarCodeType: UISwitch = {
        let switcher = UISwitch()
        switcher.setOn(true, animated: true)
        return switcher
    }()
    
    private let barCodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor =  nil
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "discountCard")
        return imageView
    }()
    
    @objc func didTapBackToFirstScreen() {
        
        self.navigationController?.popViewController(animated: true)
     /*
    let vc = firstScreen()
                
                  let navVC = UINavigationController(rootViewController: vc)
                  navVC.modalPresentationStyle = .fullScreen
                  present(navVC, animated: true)*/
    }
    
    @objc func didTapGenerateBarCode() {
        
        //MARK:QRCode BarCode generation function
        print(textFieldCartNumber.text!)
        if let text = textFieldCartNumber.text {
            let data = text.data(using: .ascii, allowLossyConversion: false)
            filter = CIFilter(name: "CICode128BarcodeGenerator")
            //filter = CIFilter(name: "CICode39BarcodeGenerator")
            //filter = CIFilter(name: "CIQRCodeGenerator")
            filter.setValue(data, forKey: "inputMessage")
            let img = UIImage(ciImage: filter.outputImage!)
            barCodeImageView.image = img
            Model.shared.setSettingsDiscountCartImg(discountCartImage: img)
        }
        textFieldCartNumber.resignFirstResponder()
    }
    
    
    @objc func  didTapCameraBarCode() {
        
       // let vc = ScannerViewController()
        if switchBarCodeType.isOn {
            Model.shared.BarCodeType = "Code39"
        } else {
            Model.shared.BarCodeType = "Code128"
        }
        let vc = ScannerViewController2()
        vc.title = "camera"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapRequestData() {
        if textFieldCartNumber.text != nil {
            Model.shared.getCardInformation3(cardCode: textFieldCartNumber.text! )
        }
        print("tapped request")
    }
    
    @objc func didTapRequestDataInsert() {
        if textFieldCartNumber.text != nil {
            ApiCaller.shared.insertCardToProfile(cardCode: textFieldCartNumber.text!) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let model): break
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
        print("tapped request")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldCartNumber.delegate = self
        view.backgroundColor = .systemBackground
        view.addSubview(descriptionLabel)
        view.addSubview(textFieldCartNumber)
        view.addSubview(buttonPhotoCartNamber)
        view.addSubview(buttonNext)
       // view.addSubview(buttonaBackToFirstScreen)
        view.addSubview(switchBarCodeTypeLabel)
        view.addSubview(switchBarCodeType)
        switchBarCodeType.setOn(true, animated: true)
        view.addSubview(buttonGenerateBarCode)
        view.addSubview(buttonRequestData)
        view.addSubview(barCodeImageView)
        view.addSubview(buttonRequestDataInsert)
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "getdiscountcartnumber"), object: nil, queue: nil) { (notification) in
            
            //MARK: обновляем картинку в основном потоке
          //  DispatchQueue.main.sync {
             self.textFieldCartNumber.text = Model.shared.discountCartNumber
                //self.tableView.reloadData()
                
        //    }
        }
        // Do any additional setup after loading the view.
    }
    
   
    @objc func didTapNext() {
        textFieldCartNumber.resignFirstResponder()
        //проверка заполнения поля и верификация карты
    
        if checkCart() {
            //ЗДесь будет sms
            didTapGenerateBarCode()
            Model.shared.setSettingsDiscountCartStatus(discountCart: textFieldCartNumber.text!)
            Model.shared.loginType = 0
            let vc = HomeFirstVC()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "homepagerefresh"), object: self)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "cartrefresh"), object: self)
            navigationController?.popToRootViewController(animated: true)
            
        } else {
            let message = UIAlertController(title: "Некорректный номер дисконтной карты", message: "Проверьте номер карты или обратитесь по телефону \n +7(473) 207-45-85", preferredStyle: .alert)
            let act = UIAlertAction(title: "ok", style: .default) { (UIAlertAction) in
                print("Cart number error")
            }
            message.addAction(act)
            present(message, animated: true, completion: nil)
        }
    }
    
    func checkCart()->Bool { //MARK:check correct cart number
        
        if textFieldCartNumber.text!.count < 8 {
            return false
        }
        
        let str = textFieldCartNumber.text
        let index = (str?.index(str!.startIndex, offsetBy: 0))!
        
        //last digits from discount cart
        let startIndex = str!.index(str!.startIndex, offsetBy: 1)
        let lastDigits = String(str![startIndex...])
        
        
        //проверяем состав введенной карты на соответсвие формату D2345678
        if  (textFieldCartNumber.text?.count == 8) && ((str![index] == "d") || (str![index] == "D")) &&  lastDigits.isNumeric {
            return true
        }
        return false
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        descriptionLabel.frame = CGRect(x: 10, y: view.safeAreaInsets.top + 20, width: view.layer.frame.width - 20, height: 130)
        textFieldCartNumber.frame = CGRect(x: 10,
                                           y: descriptionLabel.frame.origin.y + descriptionLabel.frame.height + 10,
                                           width: view.layer.frame.width - 20,
                                           height: 50)
        
        switchBarCodeTypeLabel.frame = CGRect(x: 10,
                                              y:textFieldCartNumber.frame.origin.y+textFieldCartNumber.frame.height + 10,
                                              width: 150,
                                              height: 30)
        switchBarCodeType.frame = CGRect(x: view.layer.frame.width - 60,
                                         y:textFieldCartNumber.frame.origin.y+textFieldCartNumber.frame.height + 10,
                                         width: 40,
                                         height: 20)
        
        buttonPhotoCartNamber.frame = CGRect(x: 10,
                                             y: switchBarCodeTypeLabel.frame.origin.y + switchBarCodeTypeLabel.frame.height + 10,
                                             width: view.layer.frame.width - 20,
                                             height: 30)
        buttonNext.frame = CGRect(x: 10,
                                  y: buttonPhotoCartNamber.frame.origin.y + buttonPhotoCartNamber.frame.height + 10,
                                  width: view.layer.frame.width - 20,
                                  height: 30)
       /* buttonaBackToFirstScreen.frame = CGRect(x: 10,
                                                y:buttonNext.frame.origin.y+buttonNext.frame.height + 10,
                                                width: view.layer.frame.width - 20,
                                                height: 50)*/
       
        buttonGenerateBarCode.frame = CGRect(x: 10,
                                             y: buttonNext.frame.origin.y + buttonNext.frame.height+10,
                                             width: view.layer.frame.width - 20, height: 30)
        
        buttonRequestData.frame = CGRect (x:10,
                                         y: buttonGenerateBarCode.frame.origin.y + buttonGenerateBarCode.frame.height+5,
                                         width: view.layer.frame.width - 20,
                                         height: 30)
        buttonRequestDataInsert.frame = CGRect(x: 10,
                                               y: buttonRequestData.frame.origin.y + buttonRequestData.frame.height+5,
                                               width: view.layer.frame.width - 20,
                                               height: 30)
        
        let size = view.frame.width / 3 * 2
        barCodeImageView.frame = CGRect(x: view.frame.width/2-(size/2),
                                        y: buttonRequestDataInsert.frame.origin.y + buttonRequestDataInsert.frame.height + 40,
                                        width: size,
                                        height: size/2)
    }

}



extension AddCartViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        didTapNext()
        
        return true
    }
}

//MARK: Расширение проверяет в строке только цифры?
extension String {
    var isNumeric : Bool {
        return Double(self) != nil
    }
}
