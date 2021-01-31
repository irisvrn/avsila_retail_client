//
//  HomeDiscountCartThirdTableViewCell.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 17.12.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit

class HomeDiscountCartThirdTableViewCell: UITableViewCell {

            static let identifier = "HomeDiscountCartThirdTableViewCell"
            
            
            private let discountCartNumberLabel: UILabel = {
                let label = UILabel()
                label.textColor = .label
                label.numberOfLines = 1
                label.font = .systemFont(ofSize: 18, weight: .medium)
                label.textAlignment = .center
                label.text = "Номер дисконтной карты: " + Model.shared.getSettingsDiscountCartStatus()
                return label
            }()
            
            override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
              super.init(style: style, reuseIdentifier: reuseIdentifier)
                selectionStyle = .none
                contentView.addSubview(discountCartNumberLabel)
                NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "cartrefresh"), object: nil, queue: nil) { (notification) in
                    
                    //MARK: обновляем картинку в основном потоке
                  //  DispatchQueue.main.sync {
                        
                        self.discountCartNumberLabel.text = "Номер дисконтной карты: " + Model.shared.getSettingsDiscountCartStatus()
                        
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
                let size = contentView.frame.height-4
                discountCartNumberLabel.frame = CGRect(x: 10,
                                           y: 2,
                                           width: contentView.frame.width-2,
                                           height: contentView.frame.height-4)
            }
        }

