//
//  HomeDiscountCartFourthTableViewCell.swift
//  avsila_retail_client
//
//  Created by Eugene Izotov on 18.12.2020.
//  Copyright © 2020 Eugene Izotov. All rights reserved.
//

import UIKit


protocol HomeDiscountCartFourthTableViewCellDelegate: AnyObject {
   // func didTapRelatedPostButton(model: UserNotification)
    func didTapWebMoreInfo()
}


class HomeDiscountCartFourthTableViewCell: UITableViewCell {
    
    
    static let identifier = "HomeDiscountCartFourthTableViewCell"
    
    weak var delegate: HomeDiscountCartFourthTableViewCellDelegate?
    
    private let percentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.text = "Максимальная скидка"
        return label
    }()
    private let percentDigitLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemOrange
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.text = "8%"
        return label
    }()
    
    private let descriptionPercentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .tertiaryLabel
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.text = "Разная скидка на разные группы товаров. Скидка накопительная \n до 5 000 руб - 1% \n до 7 000 руб - 3% \n до 10 000 руб - 5% \n свыше 10 000 руб - 7% \n также скидка предоставляется на все работы и материалы в Автосервисе Автосила по пдресу Текстильщиков 2в/2"
        return label
    }()
    
    private let readMoreButton: UIButton = {
        let button = UIButton()
        // button.tintColor = .red
        // button.backgroundColor = .label
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("Подробнее..", for: .normal)
        // button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(percentLabel)
        contentView.addSubview(percentDigitLabel)
        contentView.addSubview(descriptionPercentLabel)
        contentView.addSubview(readMoreButton)
        readMoreButton.addTarget(self, action: #selector(tabReadMoreButton), for: .touchUpInside)
    }
    
    
    @objc func tabReadMoreButton(_ sender: Any) {
        delegate?.didTapWebMoreInfo()
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
        let size = contentView.frame.height-4
        
        percentLabel.frame = CGRect(x: 10, y: 5, width: contentView.frame.width-70, height: 30)
        percentDigitLabel.frame = CGRect(x: percentLabel.frame.origin.x+percentLabel.frame.width+5, y: 5, width: 40, height: 30)
        descriptionPercentLabel.frame = CGRect(x: 10,
                                               y: percentLabel.frame.origin.y+30,
                                               width: contentView.frame.width-10,
                                               height: contentView.frame.height-40)
        readMoreButton.frame = CGRect(x: contentView.frame.width - 150,
                                      y: contentView.frame.height - 40,
                                      width: 150,
                                      height: 40)
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        percentLabel.text = nil
        percentDigitLabel.text = nil
        descriptionPercentLabel.text = nil
        
    }
    
    func configure(with viewModel: DiscountCardVolume) {
        percentLabel.text = String(viewModel.discount!) 
        //        albumNameLabel.text = viewModel.name
        //        artistNameLabel.text = viewModel.artistName
        //        numberOfTracksLabel.text = "Tracks:\(viewModel.numberOfTracks)"
        //        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
    

}
