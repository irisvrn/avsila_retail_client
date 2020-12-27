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
            
            
            private let usernameLabel: UILabel = {
                let label = UILabel()
                label.textColor = .label
                label.numberOfLines = 1
                label.font = .systemFont(ofSize: 18, weight: .medium)
                label.textAlignment = .center
                label.text = "Номер дисконтной карты: d0251314"
                return label
            }()
            
            private let moreButton: UIButton = {
               let button = UIButton()
                button.tintColor = .label
                button.setImage(UIImage(systemName: "plus"), for: .normal)
                return button
            }()
            
            override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
              super.init(style: style, reuseIdentifier: reuseIdentifier)
                selectionStyle = .none
            //  contentView.addSubview(profilePhotoImageView)
                
              contentView.addSubview(usernameLabel)
             // contentView.addSubview(moreButton)
            //  moreButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
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
                //usernameLabel.frame = CGRect(x: 2, y: 2, width: 100, height: 50)
            /*  profilePhotoImageView.frame = CGRect(x: 2,
                                                   y: 2,
                                                   width: size,
                                                   height: size)
              profilePhotoImageView.layer.cornerRadius = size/2*/
                
              moreButton.frame = CGRect(x: contentView.frame.width-size, y: 2, width: size, height: size)
              usernameLabel.frame = CGRect(x: 10,
                                           y: 2,
                                           width: contentView.frame.width-2,
                                           height: contentView.frame.height-4)
            }
        }

