//
//  PersonalProfileButtonViewCell.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 24.02.2021.
//  Copyright © 2021 Eugene Izotov. All rights reserved.
//

import UIKit

protocol PersonalProfileButtonViewCellDelegate: AnyObject {
    func didTapSave()
    func didTapExit() 
}

class PersonalProfileButtonViewCell: UITableViewCell {

    public static let identifier = "PersonalProfileButtonViewCell"
    
    weak var delegate: PersonalProfileButtonViewCellDelegate?
    
    private let exitButton: UIButton = {
       let button = UIButton()
        button.tintColor = .secondaryLabel
        //button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.setTitle("Выйти из профиля", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        //button.backgroundColor = .systemOrange
        return button
    }()
    
    private let saveButton: UIButton = {
       let button = UIButton()
        button.tintColor = .secondaryLabel
        //button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.setTitle("Сохранить", for: .normal)
        button.backgroundColor = .systemOrange
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(exitButton)
        
        contentView.addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped(_ sender: Any) {
        print("tapped")
        delegate?.didTapSave()
    }
    
    @objc func exitButtonTapped() {
        delegate?.didTapExit()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
      
    
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

        exitButton.frame = CGRect(x: 10, y: 10, width: contentView.frame.width - 20, height: 40)
        saveButton.frame = CGRect(x: 10, y: exitButton.frame.origin.y + exitButton.frame.height + 10, width: contentView.frame.width - 20, height: 40)
        saveButton.layer.cornerRadius = 5
        //тень вокруг кнопки
        saveButton.layer.shadowRadius = 5
        saveButton.layer.shadowOpacity = 0.5
        saveButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        saveButton.layer.shadowColor = UIColor.black.cgColor
        
     
    }
}



