//
//  PersonalPropfileVC.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 24.02.2021.
//  Copyright © 2021 Eugene Izotov. All rights reserved.
//


import UIKit

struct PersonalPropfileFormModel {
    let label: String
    let placeholder: String
    var value: String?
}

final class PersonalPropfileVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var userDataArrays = [String]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.indentifier)
        tableView.register(PersonalProfileButtonViewCell.self, forCellReuseIdentifier: PersonalProfileButtonViewCell.identifier)
        
        return tableView
        }()
    
    private var models = [[PersonalPropfileFormModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configureModels()
        tableView.tableHeaderView = createTableHeaderView()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        fetchDataPersonalData() //запрос данных
        //здесь прелоадер
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapCancel))
    }
    
    private func fetchDataPersonalData() {
    
        ApiCaller.shared.getPersonalData4 { (result) in
            switch result {
            case .success(let model) :
                
                self.userDataArrays.removeAll()
               
                self.userDataArrays.append(model.user_data?.id ?? " ")
                self.userDataArrays.append(model.user_data?.login ?? " ")
                self.userDataArrays.append(model.user_data?.email ?? " ")
                self.userDataArrays.append(model.user_data?.phone ?? " ")
                self.userDataArrays.append(model.user_data?.name ?? " ")
                self.userDataArrays.append(model.user_data?.last_name ?? " ")
                
                DispatchQueue.main.sync {
            
                    self.configureModels()
                    self.tableView.reloadData()
                }
            case .failure(let error) :
                print(error)
                break
            }
        }
    }
    
    private func configureModels() {
        //name, username, website, bio
        let section1Labels = ["id","Логин","e-mail","Телефон", "Имя", "Фамилия"]
        var section1 = [PersonalPropfileFormModel]()
        
        for i in 0...section1Labels.count-1 {
            var model = PersonalPropfileFormModel(label: "", placeholder: "")
            
            if userDataArrays.count > 1 {
                model = PersonalPropfileFormModel(label: section1Labels[i],placeholder: "Введите \(section1Labels[i])...", value: userDataArrays[i])
            } else {
                model = PersonalPropfileFormModel(label: section1Labels[i],placeholder: "Введите \(section1Labels[i])...", value: nil)
            }
            section1.append(model)
        }
        models.append(section1)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //MARK: - TableView
    
    private func createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/4).integral)
        
        let size = header.frame.height/1.5
        let profilePhotoButton = UIButton(frame: CGRect(x: (view.frame.width-size)/2,
                                                        y: (header.frame.height-size)/2,
                                                        width: size,
                                                        height: size))
        header.addSubview(profilePhotoButton)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size/2.0
        profilePhotoButton.tintColor = .label
        profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"),
                                           for: .normal)
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        
        return header
    }
    
    @objc func didTapProfilePhotoButton() {
        print("редактируем фото")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(models[section].count + 1)
        //return models[section].count + 1
        return userDataArrays.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        //if indexPath.row < Model.shared.persolaProfileDataArray.count
        if indexPath.row < userDataArrays.count
        {
            let model = models[indexPath.section][indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.indentifier, for: indexPath) as! FormTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PersonalProfileButtonViewCell.identifier, for: indexPath) as! PersonalProfileButtonViewCell
            cell.delegate = self
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row >= userDataArrays.count {
            return 120
        } else {
            return 60
        }
    }

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section == 1 else {
            return nil
        }
        
        return "Private Information"
    }
    
    func didTapExitFunc() {
        // Save info to database
        Model.shared.loginValue = false
        Model.shared.setSettingsLoginStatus(loginValue:false)
        Model.shared.setSettingsDiscountCartStatus(discountCart: "xxxxxxxx")
        Model.shared.setPhone(phone: "")
        Model.shared.setToken(token: "")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "homepagerefresh"), object: self)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapSave() {
        // Save info to database
         dismiss(animated: true, completion: nil)
    }

    @objc func didTapCancel() {
           dismiss(animated: true, completion: nil)
       }
    
    @objc func didTapChangeProfilePicture() {
              let actionSheet = UIAlertController(title: "Profile Picture",
                                                  message: "Change profile picture",
                                                  preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(actionSheet, animated: true)
        
    }
    
    
}

extension PersonalPropfileVC: FormTableViewCellDelegate {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel:PersonalPropfileFormModel) {
        // Update the model
        //print(updatedModel.value ?? "nil")
    }
}

extension PersonalPropfileVC: PersonalProfileButtonViewCellDelegate {
    func didTapExit() {
        didTapExitFunc()
        print("Ok")
        
    }
}

