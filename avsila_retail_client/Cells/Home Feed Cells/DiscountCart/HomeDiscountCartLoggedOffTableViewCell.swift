//
//  HomeDiscountCartLoggedOffTableViewCell.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 19.12.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit

protocol HomeDiscountCartLoggedOffTableViewCellDelegate: AnyObject {
    func didTapLogInDelegate()
    func didTapRegisterDelegate()
}



class HomeDiscountCartLoggedOffTableViewCell: UITableViewCell {

        static let identifier = "HomeDiscountCartLoggedOffTableViewCell"
        
        weak var delegate: HomeDiscountCartLoggedOffTableViewCellDelegate?
        
        private let noCartLogoImage: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.backgroundColor =  nil
            imageView.clipsToBounds = true
            imageView.image = UIImage(named: "logoavsila")
            return imageView
        }()
    
        private let noCartMessageLabel: UILabel = {
            let label = UILabel()
            label.textColor = .label
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20, weight: .medium)
            label.text = "Карта Автосила всегда с вами в телефоне"
            return label
        }()
        
        private let noCartMessageDescriptionLabel: UILabel = {
            let label = UILabel()
            label.textColor = .secondaryLabel
            label.numberOfLines = 0
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 18, weight: .medium)
            label.text = "Регистрируйтесь в программе лояльности и получайте скидки на запчасти и работы в автосервисе"
            return label
        }()
    
        private let logInButton: UIButton = {
           let button = UIButton()
           // button.tintColor = .orange
            button.setTitleColor(.label, for: .normal)
            button.setTitle("Войти", for: .normal)
           // button.backgroundColor = .orange
           
            button.layer.masksToBounds = true
            //button.setImage(UIImage(systemName: "plus"), for: .normal)
            return button
        }()
    
        private let registerButton: UIButton = {
           let button = UIButton()
           // button.tintColor = .label
            button.setTitleColor(.white, for: .normal)
//            button.layer.borderWidth = 1
//            button.layer.borderColor = .init(gray: 1, alpha: 1)
            button.backgroundColor = .orange
            button.setTitle("Зарег-ся", for: .normal)
           //button.setImage(UIImage(systemName: "plus"), for: .normal)
            return button
        }()
    
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
            selectionStyle = .none
        //  contentView.addSubview(profilePhotoImageView)
          contentView.addSubview(noCartLogoImage)
          contentView.addSubview(noCartMessageLabel)
          contentView.addSubview(noCartMessageDescriptionLabel)
          contentView.addSubview(logInButton)
          contentView.addSubview(registerButton)
          logInButton.addTarget(self, action: #selector(didTapLogIn), for: .touchUpInside)
          registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        }
        
        
        @objc func didTapLogIn(_ sender: Any) {
   
            delegate?.didTapLogInDelegate()


        }
        
    @objc func didTapRegister(_ sender: Any) {
     
        delegate?.didTapRegisterDelegate()

    }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    //      public func configure(with model: User) {
    //          usernameLabel.text = model.username
    //        profilePhotoImageView.image = UIImage(systemName: "person.circle")
    //          profilePhotoImageView.sd_setImage(with: model.profilePhoto, completed: nil)
    //
    //      }
          
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }

        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            logInButton.layer.borderWidth = 2
            logInButton.layer.borderColor = CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 1)
        
            logInButton.layer.cornerRadius = 5
            
            registerButton.layer.cornerRadius = 5
            let size = contentView.frame.height-4
            let buttonSize = contentView.frame.width/8
            //usernameLabel.frame = CGRect(x: 2, y: 2, width: 100, height: 50)
        /*  profilePhotoImageView.frame = CGRect(x: 2,
                                               y: 2,
                                               width: size,
                                               height: size)
          profilePhotoImageView.layer.cornerRadius = size/2*/
            
          
            
            noCartLogoImage.frame = CGRect(x: 10,
                                           y: 5,
                                           width: contentView.frame.width-20,
                                           height: 65)
          noCartMessageLabel.frame = CGRect(x: 40,
                                            y: noCartLogoImage.frame.origin.y+70,
                                       width: contentView.frame.width-80,
                                       height: 60)
            noCartMessageDescriptionLabel.frame = CGRect(x: 10,
                                                         y: noCartMessageLabel.frame.origin.y+70,
                                                         width: contentView.frame.width-20,
                                                         height: 80)
            logInButton.frame = CGRect(x: contentView.frame.width/2 - 130,
                                       y: noCartMessageDescriptionLabel.frame.origin.y+80,
                                       width: 120,
                                       height: 40)
            registerButton.frame = CGRect(x: contentView.frame.width/2 + 10,
                                          y: noCartMessageDescriptionLabel.frame.origin.y+80,
                                          width: 120,
                                          height: 40)
        }
    }

