//
//  ServiceFirstTableViewCell.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 21.12.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit

protocol ServiceFirstTableViewCellDelegate: AnyObject {
   // func didTapRelatedPostButton(model: UserNotification)
    func didTapService()
}

class ServiceFirstTableViewCell: UITableViewCell {

            static let identifier = "ServiceFirstTableViewCell"
            
            weak var delegate: ServiceFirstTableViewCellDelegate?
            
        private let mainLabel: UILabel = {
            let label = UILabel()
            label.textColor = .white
            label.numberOfLines = 1
            label.font = .systemFont(ofSize: 20, weight: .bold )
            label.text = "Записаться на сервис"
            return label
        }()
        
        private let moreButton: UIButton = {
           let button = UIButton()
            button.tintColor = .white
            button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
            return button
        }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
            selectionStyle = .none
            contentView.backgroundColor = .systemOrange
            
          contentView.addSubview(mainLabel)
          contentView.addSubview(moreButton)
          moreButton.addTarget(self, action: #selector(goToSTO), for: .touchUpInside)
        }
        
        
        @objc func goToSTO(_ sender: Any) {
            delegate?.didTapService()
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
          mainLabel.frame = CGRect(x: 10,
                                       y: 2,
                                       width: contentView.frame.width-(size*2)-15,
                                       height: contentView.frame.height-4)
        }
    }

