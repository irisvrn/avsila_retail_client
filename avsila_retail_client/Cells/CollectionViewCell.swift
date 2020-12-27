//
//  CollectionViewCell.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 20.07.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    let cellLbl : UILabel = {
       let lbl = UILabel()
       lbl.textColor = .systemGray2
     //  lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.font = UIFont.systemFont(ofSize: 14)
       lbl.textAlignment = .left
       lbl.frame = CGRect(x: 1, y: 80, width:120, height: 40)
       lbl.numberOfLines = 3
       return lbl
       }()
       
        let cellImg : UIImageView = {
           let img = UIImageView()
           img.frame = CGRect(x: 1, y: 2, width:120, height: 80)
            img.image = UIImage(named: "logoavsila")
           return img
         }()
       
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           addSubview(cellLbl)
           addSubview(cellImg)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
