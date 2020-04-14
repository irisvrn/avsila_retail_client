//
//  searchTableViewCell.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 28.03.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit

class searchTableViewCell: UITableViewCell {
   
   let lbl1 : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .darkGray
    lbl.font = UIFont.boldSystemFont(ofSize: 12)
    lbl.textAlignment = .left
    return lbl
    }()
    
   let lbl2 : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.boldSystemFont(ofSize: 12)
    lbl.textAlignment = .left
    
    return lbl
    }()
    
    let lbl3 : UILabel = {
     let lbl = UILabel()
     lbl.textColor = .darkGray
     lbl.font = UIFont.boldSystemFont(ofSize: 14)
     lbl.textAlignment = .left
     lbl.numberOfLines = 4
     return lbl
     }()
    
    let lbl4 : UILabel = {
     let lbl = UILabel()
     lbl.textColor = .blue
     lbl.font = UIFont.boldSystemFont(ofSize: 16)
     lbl.textAlignment = .right
     return lbl
     }()
    
    let lbl5 : UILabel = {
      let lbl = UILabel()
      lbl.textColor = .black
      lbl.font = UIFont.boldSystemFont(ofSize: 14)
      lbl.textAlignment = .right
      return lbl
      }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(lbl1)
        self.contentView.addSubview(lbl2)
        self.contentView.addSubview(lbl3)
        self.contentView.addSubview(lbl4)
        self.contentView.addSubview(lbl5)
        
        
        lbl1.layer.masksToBounds = true
        lbl1.translatesAutoresizingMaskIntoConstraints = false
        lbl1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        lbl1.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        lbl1.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lbl1.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        lbl2.layer.masksToBounds = true
        lbl2.translatesAutoresizingMaskIntoConstraints = false
        lbl2.topAnchor.constraint(equalTo: lbl1.bottomAnchor, constant: -5).isActive = true
        lbl2.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        lbl2.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lbl2.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        lbl3.layer.masksToBounds = true
        lbl3.translatesAutoresizingMaskIntoConstraints = false
        lbl3.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        lbl3.leftAnchor.constraint(equalTo: lbl1.rightAnchor, constant: 5).isActive = true
        lbl3.widthAnchor.constraint(equalToConstant: 200).isActive = true
        lbl3.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        lbl4.layer.masksToBounds = true
        lbl4.translatesAutoresizingMaskIntoConstraints = false
        lbl4.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        lbl4.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        lbl4.widthAnchor.constraint(equalToConstant: 80).isActive = true
        lbl4.heightAnchor.constraint(equalToConstant: 30).isActive = true
    
        lbl5.layer.masksToBounds = true
        lbl5.translatesAutoresizingMaskIntoConstraints = false
        lbl5.topAnchor.constraint(equalTo: lbl4.bottomAnchor, constant: 5).isActive = true
        lbl5.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        lbl5.widthAnchor.constraint(equalToConstant: 80).isActive = true
        lbl5.heightAnchor.constraint(equalToConstant: 30).isActive = true

     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
     
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
