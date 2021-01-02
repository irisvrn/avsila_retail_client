//
//  fLoginVC.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 08.03.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit
import Foundation

class fLoginVC: UITableViewController {

    var urlChangePass = "https://avsila.ru/auth/?forgot_password=yes" //страница смены пароля
    
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func changePassword(_ sender: Any) {
       
        var alert = UIAlertController(title: "Восстановление пароля", message: "Восстановить пароль можно на сайте avsila.ru", preferredStyle: .alert)
        var alertAction1 = UIAlertAction(title: "Перейти на сайт", style: .default) { (UIAlertAction) in
           // print("Перейти на сайт")
            self.openUrlSafari()
        }
        var alertAction2 = UIAlertAction(title: "Не сейчас", style: .cancel, handler: nil)
        
        alert.addAction(alertAction1)
        alert.addAction(alertAction2)
        
         present(alert, animated: true, completion: nil)
        
    }
    
    func openUrlSafari() {
        if let url = NSURL(string: urlChangePass) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var logInOutlet: UIButton!
    
    @IBAction func logInSMSBtn(_ sender: Any) {
                   
      
        let smsPage = self.storyboard?.instantiateViewController(identifier: "logInSMSTVC") as! logInSMSTVC
                     let appDelegate = UIApplication.shared.delegate
                     appDelegate?.window??.rootViewController = smsPage
    }
    
    @IBAction func logInBtn(_ sender: Any) {
        // http request
        
        
        if loginTextField.text == "ied" && passwordTextField.text == "hornetf18" {
            Model.shared.loginValue = true
            Model.shared.setSettingsLoginStatus(loginValue:true)
            let mainPage = self.storyboard?.instantiateViewController(identifier: "tabViewCont") as! UITabBarController
             let appDelegate = UIApplication.shared.delegate
             appDelegate?.window??.rootViewController = mainPage
        } else {
            let message = UIAlertController(title: "Неправильный логин или пароль", message: "Восстановить пароль можно на сайте avsila.ru или войти по СМС", preferredStyle: .alert)
                  let act = UIAlertAction(title: "ok", style: .default, handler: nil)
                  message.addAction(act)
                  present(message, animated: true, completion: nil)
        }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
      
    }
    
     override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      /*  logInOutlet.layer.cornerRadius = 15
        logInOutlet.layer.shadowRadius = 5
        logInOutlet.layer.shadowOpacity = 0.5
        logInOutlet.layer.shadowOffset = CGSize(width: 3, height: 3)
        logInOutlet.layer.shadowColor = UIColor.black.cgColor

        logInOutlet.setTitleColor(.white, for: .normal)
        logInOutlet.layer.masksToBounds = true // необходимо для фона и для constraints
            
        let gradientColor = CAGradientLayer()
        gradientColor.frame = logInOutlet.layer.bounds
        
      //  gradientColor.colors = [UIColor.blue.cgColor,UIColor.red.withAlphaComponent(1).cgColor]
        gradientColor.colors = [UIColor.blue.cgColor,UIColor.orange.cgColor]
        gradientColor.locations = [0.0, 1.0]
        gradientColor.startPoint = CGPoint(x: 0, y: 0)
        gradientColor.endPoint = CGPoint(x: 1, y: 1)
//
        logInOutlet.layer.insertSublayer(gradientColor, at: 0)*/
    }

    // MARK: - Table view data source

    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
