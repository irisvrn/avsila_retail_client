//
//  personalTVC.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 15.02.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit

class personalTVC: UITableViewController {

    @IBOutlet weak var saveBtnOutlet: UIButton!
    
    @IBAction func logOutBtn(_ sender: Any) {
        //MARK: запустить controller с входом
        Model.shared.loginValue = false
        Model.shared.setSettingsLoginStatus(loginValue:false)
        
        self.dismiss(animated: true, completion: nil)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "homepagerefresh"), object: self)
        
        /*
        let loginPage = self.storyboard?.instantiateViewController(identifier: "fLoginVC") as! fLoginVC
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = loginPage
        
        Model.shared.setSettingsLoginStatus(loginValue:false)*/
    }
    
    
    @IBAction func saveBtnAction(_ sender: Any) {
           self.dismiss(animated: true, completion: nil)
          // self.presentationMode.wrappedValue.dismiss()
       }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
       // self.presentationMode.wrappedValue.dismiss()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
          saveBtnOutlet.layer.cornerRadius = 15
         //  saveBtnOutlet.clipsToBounds = true
           
           saveBtnOutlet.layer.shadowRadius = 5
           saveBtnOutlet.layer.shadowOpacity = 0.5
           saveBtnOutlet.layer.shadowOffset = CGSize(width: 3, height: 3)
           saveBtnOutlet.layer.shadowColor = UIColor.black.cgColor
           
        }
        
     /*   saveBtnOutlet.layer.cornerRadius = 15*/
        //saveBtnOutlet.clipsToBounds = true
        /*
        saveBtnOutlet.layer.shadowRadius = 5
        saveBtnOutlet.layer.shadowOpacity = 0.5
        saveBtnOutlet.layer.shadowOffset = CGSize(width: 3, height: 3)
        saveBtnOutlet.layer.shadowColor = UIColor.black.cgColor
        */
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

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
