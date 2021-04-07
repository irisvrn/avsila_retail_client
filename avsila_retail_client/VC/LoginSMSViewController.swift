//
//  LoginSMSViewController.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 02.01.2021.
//  Copyright © 2021 Eugene Izotov. All rights reserved.
//

//curl --data-urlencode Login=SMS-TEST --data-urlencode Password=SMS-TEST --data-urlencode Source=SMS4B-Test --data-urlencode Phone=+7900000000 --data-urlencode Text="Test Message from X" https://sms4b.ru/ws/sms.asmx/SendSMS

//https://www.sms4b.ru/programs/clearlinux.php

// https://sms4b.ru/ws/sms.asmx/SendSMS
//POST /ws/sms.asmx/SendSMS HTTP/1.1
//Host: sms4b.ru
//Content-Type: application/x-www-form-urlencoded
//Content-Length: length
//
//Login=string&Password=string&Source=string&Phone=string&Text=string


import UIKit

class LoginSMSViewController: UIViewController {

    var rndcode = Int()
    var myTimer = Timer()
    var timerTime: Int = 0
    var phone:String = ""
        
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }

    
    private let startLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите номер телефона на который будет отправлено сообщение с кодом"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите код из SMS"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.isHidden = true
        return label
    }()
    
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.text = "сек"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.isHidden = true
        return label
    }()
    
    private let statusApiLabel: UILabel = {
        let label = UILabel()
        label.text = "Статус подключения"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .systemBlue
        return label
    }()

    
    private let phoneInput: UITextField = {
        let field = UITextField()
        field.placeholder = "Телефон"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.font = .systemFont(ofSize: 22, weight: .regular )
        field.keyboardType = .phonePad
        field.addTarget(self, action: #selector(phoneInputCheck), for: UIControl.Event.editingChanged)
        return field
    }()
    
    private let getCodeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Получить код", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(getSMSCodeBtn), for: .touchUpInside)
        return button
    }()
    
    private let checkPhoneButtonIn: UIButton = {
        let button = UIButton()
        button.setTitle("in", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
       // button.isEnabled = false
        let rr = 1
        button.addTarget(self, action: #selector(checkPhoneIn), for: .touchUpInside)
        return button
    }()
    
    private let checkPhoneButtonSt: UIButton = {
        let button = UIButton()
        button.setTitle("getData", for: .normal)
        button.setTitleColor(.systemGreen, for: .normal)
       // button.isEnabled = false
        button.addTarget(self, action: #selector(checkPhoneSt), for: .touchUpInside)
        return button
    }()
    
    private let checkPhoneButtonOut: UIButton = {
        let button = UIButton()
        button.setTitle("out", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
       // button.isEnabled = false
        button.addTarget(self, action: #selector(checkPhoneOut), for: .touchUpInside)
        return button
    }()
    
    private let codeInput:UITextField = {
        let field = UITextField()
        field.placeholder = "код"
        field.returnKeyType = .next
        //field.leftViewMode = .always
        //field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        field.textAlignment = .center
        field.font = .systemFont(ofSize: 24, weight: .bold )
        field.keyboardType = .numberPad
        field.isHidden = true
        field.addTarget(self, action: #selector(codeInputChange), for: UIControl.Event.editingChanged)
        return field
    }()
    
        
//        @IBAction func phoneInputFocus(_ sender: UITextField) {
//            phoneInput.text = "+7 ("
//
//            let arbitraryValue: Int = 4
//            if let newPosition = phoneInput.position(from: phoneInput.beginningOfDocument, offset: arbitraryValue) {
//
//                phoneInput.selectedTextRange = phoneInput.textRange(from: newPosition, to: newPosition)
//            }
//        }
        
        
            
        @objc private func phoneInputCheck(_ sender: UITextField) {
           
            let  char = String(describing: String.Encoding.utf8)
             let isBackSpace = strcmp(char, "\\b")

             if (isBackSpace == -92) {
                 print("Backspace was pressed")
                 phoneInput.text!.removeLast()
             }
            
                if (phoneInput.text?.count)! == 3
                {
                    phoneInput.text = "(\(phoneInput.text!)) "  //There we are ading () and space two things
                }
                if (phoneInput.text?.count)! == 7
                              {
                                  phoneInput.text = "\(phoneInput.text!)) "  //There we are ading () and space two things
                              }
                else if (phoneInput.text?.count)! == 12
                {
                    phoneInput.text = "\(phoneInput.text!)-" //there we are ading - in textfield
                }
                else if (phoneInput.text?.count)! == 15
                         {
                             phoneInput.text = "\(phoneInput.text!)-" //there we are ading - in textfield
                         }
                else if (phoneInput.text?.count)! == 18
                {
                    getCodeButton.isEnabled = true
                    getCodeButton.setTitleColor(.systemBlue, for: .normal)
                    print("complete")
                }
                else if (phoneInput.text?.count)! > 18
                {
                    print("false")
                }
            
            
        }
    
    @objc func checkPhoneIn() {
        
        Model.shared.loginValue = true
        Model.shared.setSettingsLoginStatus(loginValue:true)
        print("Номер телефона \(phone)")
        Model.shared.setPhone(phone: phone)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "homepagerefresh"), object: self)
        Model.shared.loginType = 0
        self.navigationController?.popToRootViewController(animated: true)
        
        
        }

    
    @objc func checkPhoneSt() {
            
        }
    
    @objc func checkPhoneOut() {
        
        }
    
        @objc private func getSMSCodeBtn(_ sender: Any) {
            
            //MARK: validate phone number empty and bigger
            if (phoneInput.text == "") || (phoneInput.text!.count > 18 ) || (phoneInput.text!.count < 18 ) {
                let message = UIAlertController(title: "Внимание!", message: "Введите корректный номер телефона \(phoneInput.text?.count)", preferredStyle: .alert)
                            // let act = UIAlertAction(title: "ok", style: .default, handler: )
                    let act3 = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                
                    message.addAction(act3)
                    present(message, animated: true, completion: nil)
                return
            } else {
                let str = String(phoneInput.text!)
                
            // MARK:clean phone number
            var replaced = str.replacingOccurrences(of: "(", with: "")
                replaced = replaced.replacingOccurrences(of: ")", with: "")
                replaced = replaced.replacingOccurrences(of: "-", with: "")
                replaced = replaced.replacingOccurrences(of: " ", with: "")
                replaced = replaced.replacingOccurrences(of: "+", with: "")
               print(replaced)
                phone = replaced
            }

            ApiCaller.shared.phoneRegister3(phoneNumber: phone) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let model):
                        self?.statusApiLabel.text = model.message
                        print(model.message)
                        print(model.token)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
            
            //MARK: Расскоментировать на проде
            
            messageLabel.isHidden = false
            counterLabel.isHidden = false
            codeInput.isHidden = false
            codeInput.becomeFirstResponder() //фокус на поле ввода кода
            timerTime = 120
            startTimer()
        
        }
        
     
        
        @IBOutlet weak var codeinputOutlet: UITextField!
        

        @objc private func codeInputChange(_ sender: UITextField) {
            
            if codeInput.text?.count == 4 {
                    
                    //MARK: запрос к серверу - поиск по номеру телефона пользователя , если 2 то обратиться в сервис
                print("Телефон: \(phone) код: \(codeInput.text!)")
             
                var status = true
                
                ApiCaller.shared.phoneCheckCode3(phoneNumber: self.phone, codeNumber: self.codeInput.text!) { [weak self] result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let model):
                            self?.statusApiLabel.text = model.message ?? ""
                        
                        if (model.token != nil) && (model.token != "") {
                            Model.shared.setToken(token: model.token!)
                            if (self?.phone != "") {
                                Model.shared.setPhone(phone: self?.phone ?? "")
                            }
                            
                            Model.shared.loginValue = true
                            Model.shared.setSettingsLoginStatus(loginValue:true)
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "homepagerefresh"), object: self)
                            Model.shared.loginType = 0
                            self?.navigationController?.popToRootViewController(animated: true)
                            
                           // Model.shared.status = 1
                          // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "codesuccess"), object: self)
                        } else {
                            // Model.shared.status = 0
                            //обработать ошибки по коду из смс
                            
                            print("Код неправильный")
                            
                            let message = UIAlertController(title: "Внимание!", message: "Введите корректный код ", preferredStyle: .alert)
                            let act3 = UIAlertAction(title: "Понятно", style: .cancel, handler: { (UIAlertAction) in
                                self?.codeInput.text = ""
                            })
                            message.addAction(act3)
                            self?.present(message, animated: true, completion: nil)
                        }

//                            print(model.message)
//                            print(model.token)
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
                 /*
                
                if status == true {
                    //MARK:переходим на главную страницу
                    
                //РАССКОМЕНТИРОВАТЬ надо проверить ответ от сервера если полодижетельный то
                 
                    Model.shared.loginValue = true
                    Model.shared.setSettingsLoginStatus(loginValue:true)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "homepagerefresh"), object: self)
                    Model.shared.loginType = 0
                    self.navigationController?.popToRootViewController(animated: true)
            
                } else {
                    
                    
                }*/
            } else if ((codeInput.text!.count) > 4) {
                print("Код неправильный")
                
                let message = UIAlertController(title: "Внимание!", message: "Введите корректный код ", preferredStyle: .alert)
                    let act3 = UIAlertAction(title: "Понятно", style: .cancel, handler: { (UIAlertAction) in
                                                          self.codeInput.text = ""
                                                      })
                    message.addAction(act3)
                    present(message, animated: true, completion: nil)
            }
            
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            view.addSubview(startLabel)
            view.addSubview(phoneInput)
            view.addSubview(getCodeButton)
            view.addSubview(checkPhoneButtonIn)
            //view.addSubview(checkPhoneButtonSt)
            //view.addSubview(checkPhoneButtonOut)
            view.addSubview(messageLabel)
            view.addSubview(counterLabel)
            view.addSubview(codeInput)
            view.addSubview(statusApiLabel)
            phoneInput.delegate = self
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        startLabel.frame = CGRect(
            x: 25,
            y: view.safeAreaInsets.top+40,
            width: view.frame.width-50,
            height: 50.0)
        
        phoneInput.frame = CGRect(
            x: 25,
            y: startLabel.frame.origin.y + startLabel.frame.height+20,
            width: view.frame.width-50,
            height: 52.0)
        
        getCodeButton.frame = CGRect(
            x: 10,
            y: phoneInput.frame.origin.y+phoneInput.frame.height+10,
            width: view.frame.width-20,
            height: 50.0)
        
        checkPhoneButtonIn.frame = CGRect(
            x: 10,
            y: phoneInput.frame.origin.y+phoneInput.frame.height+30,
            width: 60,
            height: 50.0)
        checkPhoneButtonSt.frame = CGRect(
            x: 80,
            y: phoneInput.frame.origin.y+phoneInput.frame.height+30,
            width: 60,
            height: 50.0)
        checkPhoneButtonOut.frame = CGRect(
            x: 150,
            y: phoneInput.frame.origin.y+phoneInput.frame.height+30,
            width: 60,
            height: 50.0)
        
        
        
        messageLabel.frame = CGRect(
            x: 25,
            y: getCodeButton.frame.origin.y+getCodeButton.frame.height+20,
            width: view.frame.width-50,
            height: 20.0)
        counterLabel.frame = CGRect(
            x: 25,
            y: messageLabel.frame.origin.y+messageLabel.frame.height+10,
            width: view.frame.width-50,
            height: 20.0)
        codeInput.frame = CGRect(
            x: view.frame.width/2-50,
            y: counterLabel.frame.origin.y+counterLabel.frame.height+10,
            width: 100,
            height: 52.0)
        statusApiLabel.frame = CGRect(x: 10, y: view.frame.height-150, width: view.frame.width-20, height: 40)
        
    }

        func startTimer() {
             myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(myTimerAction), userInfo: nil, repeats: true)
         }
         
         
         @objc func myTimerAction() {
             if timerTime>0 {
                 timerTime -= 1
                 counterLabel.text = String(timerTime) + " сек."
             } else {
               //  myButton.setTitle("Start", for: .normal)
               //  myButton.alpha = 1
                counterLabel.text = "Время истекло. Повторите попытку."
                rndcode = 7843
                myTimer.invalidate()
             }
         }
        
        
        
    }

extension LoginSMSViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        phoneInput.text = "+7 ("
       
        let arbitraryValue: Int = 4
        if let newPosition = phoneInput.position(from: phoneInput.beginningOfDocument, offset: arbitraryValue) {

            phoneInput.selectedTextRange = phoneInput.textRange(from: newPosition, to: newPosition)
        }
    }
}
