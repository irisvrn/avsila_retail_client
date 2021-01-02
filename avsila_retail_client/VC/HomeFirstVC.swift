//
//  HomeFirstVC.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 17.12.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit

class HomeFirstVC: UIViewController {

    

    private let tableView : UITableView = {
        let tableView = UITableView()
        
        tableView.register(HomeDiscountCartFirstTableViewCell.self, forCellReuseIdentifier: HomeDiscountCartFirstTableViewCell.identifier)
        tableView.register(HomeDiscountCartSecondTableViewCell.self, forCellReuseIdentifier: HomeDiscountCartSecondTableViewCell.identifier)
        tableView.register(HomeDiscountCartThirdTableViewCell.self, forCellReuseIdentifier: HomeDiscountCartThirdTableViewCell.identifier)
        tableView.register(HomeDiscountCartFourthTableViewCell.self, forCellReuseIdentifier: HomeDiscountCartFourthTableViewCell.identifier)
        tableView.register(HomeDiscountCartLoggedOffTableViewCell.self, forCellReuseIdentifier: HomeDiscountCartLoggedOffTableViewCell.identifier)
        tableView.register(ServiceFirstTableViewCell.self, forCellReuseIdentifier: ServiceFirstTableViewCell.identifier)
        tableView.register(ActionFirstTableViewCell.self, forCellReuseIdentifier: ActionFirstTableViewCell.identifier)
        tableView.register(ActionSecondTableViewCell.self, forCellReuseIdentifier: ActionSecondTableViewCell.identifier)
        tableView.register(BlogFirstTableViewCell.self, forCellReuseIdentifier: BlogFirstTableViewCell.identifier)
        tableView.register(BlogSecondTableViewCell.self, forCellReuseIdentifier: BlogSecondTableViewCell.identifier)
        
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        view.addSubview(tableView)
        navigationItem.title = "Домой"
        configureNavigationBar()
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.barTintColor = .systemOrange
        
        //MARK: убрать разделитель между строками 
      //  tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "homepagerefresh"), object: nil, queue: nil) { (notification) in
            
            //MARK: обновляем картинку в основном потоке
          //  DispatchQueue.main.sync {
                
                self.tableView.reloadData()
                
        //    }
            print("table refreshed")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSettingsButton))
    }

   @objc func didTapSettingsButton() {
    
    if Model.shared.loginValue == true {
        let registerViewController = self.storyboard?.instantiateViewController(identifier: "personalTVC") as! personalTVC
        self.present(registerViewController, animated: true, completion: nil)
    } else {
        Model.shared.loginType = 1
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
       /* let registerViewController = self.storyboard?.instantiateViewController(identifier: "fLoginVC") as! fLoginVC
        self.present(registerViewController, animated: true, completion: nil)*/
    }
    
 /*
    let vc = personalTVC()
    vc.title = "Settings"
    navigationController?.pushViewController(vc, animated: true)*/
    }
    

}



extension HomeFirstVC: HomeDiscountCartFirstTableViewCellDelegate {
    func didTapAddDiscountCart() {
        
        if Model.shared.loginValue {
            /*
            let addCartPage = self.storyboard?.instantiateViewController(identifier: "AddCartViewController") as! AddCartViewController
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = addCartPage*/
            
            let vc = AddCartViewController()
            //vc.title = post.postTyper.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        } else {
            /*
            let vcc = logInSMSTVC()
            navigationController?.pushViewController(vcc, animated: true)
            print("we are here")
            */
          /*
            let registerViewController = self.storyboard?.instantiateViewController(identifier: "fLoginVC") as! fLoginVC
           // registerViewController.modalPresentationStyle = .fullScreen
            self.present(registerViewController, animated: true, completion: nil)*/
            
            
            
            
            Model.shared.loginType = 2
            let vc = LoginViewController()
            //vc.title = "Create Account"
            navigationController?.pushViewController(vc, animated: true)
           // present(UINavigationController(rootViewController: vc), animated: true)
            
            //vc.title = post.postTyper.rawValue
           /* vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)*/
        }
    }
}

extension HomeFirstVC: HomeDiscountCartLoggedOffTableViewCellDelegate{
    func didTapLogInDelegate() {
     
        didTapAddDiscountCart()
    }
    
    func didTapRegisterDelegate() {
        
        didTapAddDiscountCart()
    }
}

extension HomeFirstVC: HomeDiscountCartFourthTableViewCellDelegate {
    func didTapWebMoreInfo() {
        print("We are here again")
        let vc = WebMoreInfoViewController()
        vc.title = "Условия"
        vc.modalPresentationStyle = .popover
        navigationController?.pushViewController(vc, animated: true)
    }
    
        
    }


extension HomeFirstVC: ServiceFirstTableViewCellDelegate {
    func didTapService() {
        let registerViewController = self.storyboard?.instantiateViewController(identifier: "stovc") as! STOVC
        self.present(registerViewController, animated: true, completion: nil)
    }
    
    
}

extension HomeFirstVC: UITableViewDelegate,UITableViewDataSource {
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: if Model.shared.loginValue {
            return 4
        } else {
            return 2
        }
        case 1:
            return 1
        case 2:
            return 2
        case 3:
            return 2
        default:
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            switch indexPath.row  {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: HomeDiscountCartFirstTableViewCell.identifier, for: indexPath) as! HomeDiscountCartFirstTableViewCell
                cell.delegate = self
                return cell
                
            case 1:
                if Model.shared.loginValue {
                let cell = tableView.dequeueReusableCell(withIdentifier: HomeDiscountCartSecondTableViewCell.identifier, for: indexPath) as! HomeDiscountCartSecondTableViewCell
                    return cell
                    
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: HomeDiscountCartLoggedOffTableViewCell.identifier, for: indexPath) as! HomeDiscountCartLoggedOffTableViewCell
                    cell.delegate = self
                    return cell
                }
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: HomeDiscountCartThirdTableViewCell.identifier, for: indexPath) as! HomeDiscountCartThirdTableViewCell
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: HomeDiscountCartFourthTableViewCell.identifier, for: indexPath) as! HomeDiscountCartFourthTableViewCell
                cell.delegate = self
                return cell
              /*
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: HomeDiscountCartLoggedOffTableViewCell.identifier, for: indexPath) as! HomeDiscountCartLoggedOffTableViewCell
                        return cell
                
              */
                
            default:
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeDiscountCartSecondTableViewCell.identifier, for: indexPath) as! HomeDiscountCartSecondTableViewCell
                    return cell
            }
            
            
          
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeDiscountCartFirstTableViewCell.identifier, for: indexPath) as! HomeDiscountCartFirstTableViewCell
                return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ServiceFirstTableViewCell.identifier, for: indexPath) as! ServiceFirstTableViewCell
            cell.delegate = self
            return cell
        }
        
        if indexPath.section == 2 {
            switch indexPath.row  {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: ActionFirstTableViewCell.identifier, for: indexPath) as! ActionFirstTableViewCell
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: ActionSecondTableViewCell.identifier, for: indexPath) as! ActionSecondTableViewCell
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: ActionFirstTableViewCell.identifier, for: indexPath) as! ActionFirstTableViewCell
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ServiceFirstTableViewCell.identifier, for: indexPath) as! ServiceFirstTableViewCell
         
            return cell
        }
        
        
        if indexPath.section == 3 {
            switch indexPath.row  {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: BlogFirstTableViewCell.identifier, for: indexPath) as! BlogFirstTableViewCell
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: BlogSecondTableViewCell.identifier, for: indexPath) as! BlogSecondTableViewCell
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: BlogFirstTableViewCell.identifier, for: indexPath) as! BlogFirstTableViewCell
                return cell
            }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: BlogFirstTableViewCell.identifier, for: indexPath) as! BlogFirstTableViewCell
        
            return cell
        }
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeDiscountCartFirstTableViewCell.identifier, for: indexPath) as! HomeDiscountCartFirstTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            switch indexPath.row  {
            case 0: return 60
            case 1:
                if Model.shared.loginValue
                {
                    return 120
                } else {
                    return 250
                }
            case 2: return 40
            case 3: return 250
            case 4: return 250
            default: return 160
            }
           
        } else {
            return 60
        }
    }
}
