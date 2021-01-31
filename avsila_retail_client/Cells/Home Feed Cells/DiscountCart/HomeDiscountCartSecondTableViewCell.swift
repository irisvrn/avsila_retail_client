//
//  HomeDiscountCartSecondTableViewCell.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 17.12.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit

class HomeDiscountCartSecondTableViewCell: UITableViewCell {


        static let identifier = "HomeDiscountCartSecondTableViewCell"
        
        private let barCodeImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.backgroundColor =  nil
            imageView.clipsToBounds = true
            imageView.image = UIImage(named: "discountCard")
            return imageView
        }()
    
        private let barCodeButton: UIButton = {
            let button = UIButton()
            button.tintColor = .label
         //   button.backgroundColor = .white
            if (Model.shared.getSettingsDiscountCartImg() != nil) {
                button.setImage(Model.shared.getSettingsDiscountCartImg(), for: .normal)
            } else {
            button.setImage(UIImage(named: "barcode"), for: .normal)
            }
            return button
        }()
    
    private let imageBack: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
       
        @objc func didTapBarCode() {
            print("barCodeTapped")
        }
        
           override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
            selectionStyle = .none
           
            contentView.addSubview(imageBack)
            contentView.backgroundColor = .white
            //imageBack.addSubview(barCodeImageView)
            contentView.addSubview(barCodeButton)
            barCodeButton.addTarget(self, action: #selector(didTapBarCode), for: .touchUpInside)
          //  barCodeImageView.image = UIImage(named: "barcode")
            
            
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "cartrefresh"), object: nil, queue: nil) { (notification) in
                if (Model.shared.getSettingsDiscountCartImg() != nil) {
                    self.barCodeButton.setImage(Model.shared.getSettingsDiscountCartImg(), for: .normal)
                }
                //MARK: обновляем картинку в основном потоке
              //  DispatchQueue.main.sync {
                    
              
                    
            //    }
            }
            
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
        //    barCodeImageView.frame = contentView.bounds
            barCodeButton.frame = contentView.bounds
            imageBack.frame = contentView.bounds
            barCodeImageView.frame = imageBack.bounds
            let size = contentView.frame.height-4
            //usernameLabel.frame = CGRect(x: 2, y: 2, width: 100, height: 50)
        /*  profilePhotoImageView.frame = CGRect(x: 2,
                                               y: 2,
                                               width: size,
                                               height: size)
          profilePhotoImageView.layer.cornerRadius = size/2*/
          
            /*
          moreButton.frame = CGRect(x: contentView.frame.width-size, y: 2, width: size, height: size)
          usernameLabel.frame = CGRect(x: 10,
                                       y: 2,
                                       width: contentView.frame.width-(size*2)-15,
                                       height: contentView.frame.height-4)*/
        }
    }
