//
//  logInSMSTVC.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 15.03.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
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

class logInSMSTVC: UITableViewController {
var rndcode = Int()
var myTimer = Timer()
var timerTime: Int = 0
    
    @IBOutlet weak var phoneInput: UITextField!
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var getSMSbtnOutlet: UIButton!
    
    @IBAction func phoneInputFocus(_ sender: UITextField) {
        phoneInput.text = "+7 ("
       
        let arbitraryValue: Int = 4
        if let newPosition = phoneInput.position(from: phoneInput.beginningOfDocument, offset: arbitraryValue) {

            phoneInput.selectedTextRange = phoneInput.textRange(from: newPosition, to: newPosition)
        }
    }
    
   
    
    
    
    @IBAction func phoneInputCheck(_ sender: UITextField) {
       
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
                getSMSbtnOutlet.isEnabled = true
                print("complete")
            }
            else if (phoneInput.text?.count)! > 18
            {
                print("false")
            }
        
        
    }

    @IBAction func getSMSCodeBtn(_ sender: Any) {
     
        //MARK: validate phone number empty and bigger
        if (phoneInput.text == "") || (phoneInput.text!.count > 18 ) || (phoneInput.text!.count < 18 ) {
            let message = UIAlertController(title: "Внимание!", message: "Введите корректный номер телефона \(phoneInput.text?.count)", preferredStyle: .alert)
                        // let act = UIAlertAction(title: "ok", style: .default, handler: )
                let act3 = UIAlertAction(title: "Понятно", style: .cancel, handler: nil)
            
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
           print(replaced)
        }
        
        rndcode = Int.random(in: 0...9999) //генерим случайный код
        print("send sms \(rndcode)")
        
        //MARK: Расскоментировать на проде
        //Model.shared.sendSMS(code: String(rndcode))
        
        enterCodeLbl.isHidden = false
        codeinputOutlet.isHidden = false
        timerLabel.isHidden = false
        codeinputOutlet.becomeFirstResponder() //фокус на поле ввода кода
        timerTime = 20
        startTimer()
    
    }
    
 
    
    @IBOutlet weak var enterCodeLbl: UILabel!
    @IBOutlet weak var codeinputOutlet: UITextField!
    

    @IBAction func codeInputChange(_ sender: UITextField) {
        
        if codeinputOutlet.text?.count == String(rndcode).count {
            if codeinputOutlet.text == String(rndcode) {
                 print("код совпадает")
                 
                //MARK: запрос к серверу - поиск по номеру телефона пользователя , если 2 то обратиться в сервис
                
                //MARK:переходим на главную страницу
                Model.shared.loginValue = true
                let mainPage = self.storyboard?.instantiateViewController(identifier: "tabViewCont") as! UITabBarController
                 let appDelegate = UIApplication.shared.delegate
                 appDelegate?.window??.rootViewController = mainPage
                //прогрузить данные пользователя с сервера
                
            } else {
                print("Код неправильный")
                
                let message = UIAlertController(title: "Внимание!", message: "Введите корректный код ", preferredStyle: .alert)
                //let act3 = UIAlertAction(title: "Понятно", style: .cancel, handler: nil)
                let act3 = UIAlertAction(title: "Понятно", style: .cancel, handler: { (UIAlertAction) in
                    self.codeinputOutlet.text = ""
                })
                message.addAction(act3)
                present(message, animated: true, completion: nil)
            }
        } else if ((codeinputOutlet.text!.count) > String(rndcode).count) {
            print("Код неправильный")
            
            let message = UIAlertController(title: "Внимание!", message: "Введите корректный код ", preferredStyle: .alert)
                let act3 = UIAlertAction(title: "Понятно", style: .cancel, handler: { (UIAlertAction) in
                                                      self.codeinputOutlet.text = ""
                                                  })
                message.addAction(act3)
                present(message, animated: true, completion: nil)
        }
        
     //   print(codeinputOutlet.text)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func startTimer() {
         myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(myTimerAction), userInfo: nil, repeats: true)
     }
     
     
     @objc func myTimerAction() {
         if timerTime>0 {
             timerTime -= 1
             timerLabel.text = String(timerTime) + " сек."
         } else {
           //  myButton.setTitle("Start", for: .normal)
           //  myButton.alpha = 1
            timerLabel.text = "Время истекло. Повторите попытку."
            rndcode = 7843
            myTimer.invalidate()
         }
     }
    
    
    
}
