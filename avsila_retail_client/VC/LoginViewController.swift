//
//  LoginViewController.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 02.01.2021.
//  Copyright © 2021 Eugene Izotov. All rights reserved.
//

import UIKit
import SafariServices

class LoginViewController: UIViewController {
        
        struct Constants {
            static let cornerRadius: CGFloat = 8.0
        }

        private let usernameEmailField: UITextField = {
            let field = UITextField()
            field.placeholder = "Username or Email..."
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
            return field
        }()
        
        private let passwordField: UITextField = {
            let field  = UITextField()
            field.placeholder = "Password..."
            field.returnKeyType = .continue
            field.leftViewMode = .always
            field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
            field.autocapitalizationType = .none
            field.autocorrectionType = .no
            field.layer.masksToBounds = true
            field.layer.cornerRadius = Constants.cornerRadius
            field.isSecureTextEntry = true
            field.backgroundColor = .secondarySystemBackground
            field.layer.borderWidth = 1.0
            field.layer.borderColor = UIColor.secondaryLabel.cgColor
            return field
        }()
        
        private let loginButton: UIButton = {
            let button = UIButton()
            button.setTitle("Log in", for: .normal)
            button.layer.masksToBounds = true
            button.layer.cornerRadius = Constants.cornerRadius
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector (didTapLoginButton), for: .touchUpInside)
            return button
           }()
        
        private let termsButton: UIButton = {
            let button = UIButton()
            button.setTitle("Условия обслуживания", for: .normal)
            button.setTitleColor(.secondaryLabel, for: .normal)
            return button
        }()
        
        private let privacyButton: UIButton = {
            let button = UIButton()
            button.setTitle("Политика безопасности", for: .normal)
            button.setTitleColor(.secondaryLabel, for: .normal)
            return button
         }()
        
        private let loginSMSButton: UIButton = {
            let button = UIButton()
            button.setTitleColor(.label, for: .normal)
            button.setTitle("Войти по СМС ", for: .normal)
            return button
        }()
    
        private let createAccountButton: UIButton = {
            let button = UIButton()
            button.setTitleColor(.label, for: .normal)
            button.setTitle("Новый пользователь? Создать Account", for: .normal)
            return button
           }()
        
        private let headerView: UIView = {
            let header = UIView()
            header.clipsToBounds = true
            let backgroundImageView = UIImageView(image: UIImage(named: "logoavsila"))
            header.addSubview(backgroundImageView)
            return header
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
            
            loginSMSButton.addTarget(self, action: #selector(didTaploginSMSButton), for: .touchUpInside)
            
            createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
            
            termsButton.addTarget(self, action: #selector(didTapTermButton), for: .touchUpInside)
            
            privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
               
            usernameEmailField.delegate = self
            passwordField.delegate = self
            addSubviews()
            view.backgroundColor = .systemBackground
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "authLoginRefresh"), object: nil, queue: nil) { (notification) in
                
                
                
                DispatchQueue.main.sync {
                    
                    Model.shared.loginValue = true
                    Model.shared.setSettingsLoginStatus(loginValue:true)
                   // print("Номер телефона \(phone)")
                   // Model.shared.setPhone(phone: phone)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "homepagerefresh"), object: self)
                    Model.shared.loginType = 0
                    self.navigationController?.popToRootViewController(animated: true)
                    
                    /*
                    let message = UIAlertController(title: "Вы зарегистрировались ", message: "Token \(Model.shared.getToken())", preferredStyle: .alert)
                      let act = UIAlertAction(title: "ok", style: .default, handler: nil)
                      message.addAction(act)
                    self.present(message, animated: true, completion: nil)
                     */
                    
               }
               
            }
            
            
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            headerView.frame = CGRect(
                x: 0,
                y: 0.0,
                width: view.frame.width,
                height: view.frame.height/3.0)
            
            usernameEmailField.frame = CGRect(
                x: 25,
                y: headerView.frame.origin.y + headerView.frame.height+40,
                width: view.frame.width-50,
                height: 52.0)
            
            passwordField.frame = CGRect(
                x: 25,
                y: usernameEmailField.frame.origin.y + usernameEmailField.frame.height+10,
                width: view.frame.width-50,
                height: 52.0)
            
            loginButton.frame = CGRect(
                x: 25,
                y: passwordField.frame.origin.y + passwordField.frame.height+10,
                width: view.frame.width-50,
                height: 52.0)
            
            loginSMSButton.frame = CGRect(
                x: 25,
                y: loginButton.frame.origin.y + loginButton.frame.height+10,
                width: view.frame.width-50,
                height: 52.0)
            
            createAccountButton.frame = CGRect(
                x: 25,
                y: loginSMSButton.frame.origin.y + loginSMSButton.frame.height+10,
                width: view.frame.width-50,
                height: 52.0)
            
            termsButton.frame = CGRect(
                x: 10,
                y: view.frame.height-view.safeAreaInsets.bottom-100,
                width: view.frame.width-20,
                height: 50.0)
            
            privacyButton.frame = CGRect(
                x: 10,
                y: view.frame.height-view.safeAreaInsets.bottom-50,
                width: view.frame.width-20,
                height: 50.0)
            
            configureHeaderView()
            
        }
        
        func configureHeaderView() {
            guard headerView.subviews.count == 1 else {
                return
            }
            
            guard let backgroundView = headerView.subviews.first else {
                return
            }
            backgroundView.frame = headerView.bounds
            
            //Add instagram logo
            let imageView = UIImageView(image: UIImage(named: "text"))
            headerView.addSubview(imageView)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: headerView.frame.width/4.0,
                                     y: view.safeAreaInsets.top,
                                     width: headerView.frame.width/2.0,
                                     height: headerView.frame.height - view.safeAreaInsets.top)
        }
        
        
        private func addSubviews(){
            view.addSubview(usernameEmailField)
            view.addSubview(passwordField)
            view.addSubview(loginButton)
            view.addSubview(termsButton)
            view.addSubview(privacyButton)
            view.addSubview(loginSMSButton)
            view.addSubview(createAccountButton)
            view.addSubview(headerView)
        }
        
        @objc private func didTapLoginButton() {
          
            passwordField.resignFirstResponder()
            usernameEmailField.resignFirstResponder()
            
            guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
                let password = passwordField.text, !password.isEmpty, password.count >= 7 else {
                return
            }
            
            //login functionality
            var username: String?
            var email:String?
            
            if usernameEmail.contains("@"), usernameEmail.contains(".") {
                //email
                email = usernameEmail
            }
            else {
                //username
                 username = usernameEmail
                print("here \(username)")
            }
              print("here \(email)")
            
            // MARК: здесь запрос к серверу на проверку логина и пароля
            
            Model.shared.authLoginName3(usernameEmail:usernameEmail, password:password)
            
            /*
            if usernameEmail == "ied" && password == "hornetf18" {
                
                
                Model.shared.loginValue = true
                Model.shared.setSettingsLoginStatus(loginValue:true)
                print("We are here")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "homepagerefresh"), object: self)
                
                
                if Model.shared.loginType == 1 {
                    Model.shared.loginType = 0
                    self.navigationController?.popViewController(animated: true)
                    // запрос к базе. получаем все данные по учетке + дисконтные карты если есть
                }
                else {
                    let vcc = AddCartViewController()
                    navigationController?.pushViewController(vcc, animated: true)
                }
           
                
            } else {
                let message = UIAlertController(title: "Неправильный логин или пароль", message: "Восстановить пароль можно на сайте avsila.ru или войти по СМС", preferredStyle: .alert)
                      let act = UIAlertAction(title: "ok", style: .default, handler: nil)
                      message.addAction(act)
                      present(message, animated: true, completion: nil)
            }
            */
            
            /*
            AuthManager.shared.liginUser(username: username, email: email, password: password) {success in
                DispatchQueue.main.async {
                if success {
                     print("success")
                    //user loged in
                    self.dismiss(animated: true, completion: nil)
                } else {
                    //error occurred
                    print("alert")
                    let alert = UIAlertController(title: "Log In Error", message: "We were unable to log you in", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                    
                }
            }
            }
            */
        }
        
        @objc private func didTaploginSMSButton() {
            let vc = LoginSMSViewController()
            vc.title = "Вход по СМС"
            vc.navigationItem.backButtonTitle = "Назад"
            navigationController?.pushViewController(vc, animated: true)
        }
    
    
        @objc private func didTapTermButton() {
            guard let url = URL(string: "https://avsila.ru/for-clients/conditions") else {
                return
            }
            
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
        
        @objc private func didTapPrivacyButton() {
            guard let url = URL(string: "https://avsila.ru/for-clients/conditions") else {
                return
            }
            
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
        
        @objc private func didTapCreateAccountButton() {
            guard let url = URL(string: "https://avsila.ru/registration") else {
                return
            }
            
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
          /*  let vc = RegistrationViewController()
            vc.title = "Create Account"
            
            present(UINavigationController(rootViewController: vc), animated: true)*/
            //present(vc, animated: true)
        }
        
        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */

    }

    extension LoginViewController: UITextFieldDelegate{
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField == usernameEmailField{
                passwordField.becomeFirstResponder()
            }
            else if textField == passwordField {
                didTapLoginButton()
            }
            return true
        }
    }
