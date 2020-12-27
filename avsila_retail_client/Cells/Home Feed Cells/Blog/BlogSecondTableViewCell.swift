//
//  BlogSecondTableViewCell.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 22.12.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit

protocol BlogSecondTableViewCellDelegate: AnyObject {
   // func didTapRelatedPostButton(model: UserNotification)
    func didTapService()
}


class BlogSecondTableViewCell: UITableViewCell {
            
                        static let identifier = "BlogSecondTableViewCell"
                        
                        weak var delegate: BlogSecondTableViewCellDelegate?
                        
                    private let mainLabel: UILabel = {
                        let label = UILabel()
                        label.textColor = .secondaryLabel
                        label.numberOfLines = 1
                        label.font = .systemFont(ofSize: 18, weight: .bold )
                        label.text = "Список новостей и блога СТО (collView)"
                        return label
                    }()
                    
                    private let moreButton: UIButton = {
                       let button = UIButton()
                        button.tintColor = .secondaryLabel
                        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
                        return button
                    }()
                    
                    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                      super.init(style: style, reuseIdentifier: reuseIdentifier)
                        selectionStyle = .none
                        contentView.backgroundColor = .systemBackground
                        
                      contentView.addSubview(mainLabel)
                      contentView.addSubview(moreButton)
                      moreButton.addTarget(self, action: #selector(addCartButton), for: .touchUpInside)
                    }
                    
                    
                    @objc func addCartButton(_ sender: Any) {
                        print("tapped")
                        delegate?.didTapService()
                //        delegate?.didTapMoreButton()
                //       let registerViewController = storyboard?.instantiateViewController(identifier: "AddCartViewController") as! AddCartViewController
                //        self.navigationController?.pushViewController(registerViewController, animated: true)
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




