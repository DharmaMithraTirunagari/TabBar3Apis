//
//  FoodCell.swift
//  TabBar3Apis
//
//  Created by Srikanth Kyatham on 12/11/24.
//

import UIKit

class FoodCell: UITableViewCell {
    
    static let identifier = "FoodCell"
    
    private let foodGroupsNameLabel = UILabel()
//    private let foodGroupsDescriptionLabel = UILabel()
//    private let foodGroupsIdLabel = UILabel()
    private let foodItemsNameLabel = UILabel()
//    private let foodItemsDescriptionLabel = UILabel()
//    private let foodItemsIdLabel = UILabel()
    private let foodItemImageView = UIImageView()
    private let foodItemWeightLabel = UILabel()
    private let foodItemPriceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        foodItemImageView.translatesAutoresizingMaskIntoConstraints = false
        foodItemImageView.contentMode = .scaleAspectFit
        foodItemImageView.layer.cornerRadius = 8
        foodItemImageView.clipsToBounds = true
        
        let labels = [
            foodGroupsNameLabel,
//            foodGroupsDescriptionLabel,
//            foodGroupsIdLabel,
            
            foodItemsNameLabel,
            foodItemPriceLabel,
            foodItemWeightLabel
//            foodItemsDescriptionLabel,
//            foodItemsIdLabel
        ]
        labels.forEach { $0.translatesAutoresizingMaskIntoConstraints = false; $0.numberOfLines = 0 }
        
        contentView.addSubview(foodItemImageView)
        labels.forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            foodItemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                        foodItemImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                        foodItemImageView.widthAnchor.constraint(equalToConstant: 80),
                        foodItemImageView.heightAnchor.constraint(equalToConstant: 80),
                        
                      foodItemsNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            foodItemsNameLabel.leadingAnchor.constraint(equalTo: foodItemImageView.trailingAnchor, constant: 10),
            foodItemsNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                        
                        foodItemWeightLabel.topAnchor.constraint(equalTo: foodItemsNameLabel.bottomAnchor, constant: 5),
            foodItemWeightLabel.leadingAnchor.constraint(equalTo: foodItemsNameLabel.leadingAnchor),
            foodItemWeightLabel.trailingAnchor.constraint(equalTo: foodItemsNameLabel.trailingAnchor),
                        
                        foodItemPriceLabel.topAnchor.constraint(equalTo: foodItemWeightLabel.bottomAnchor, constant: 5),
            foodItemPriceLabel.leadingAnchor.constraint(equalTo: foodItemsNameLabel.leadingAnchor),
            foodItemPriceLabel.trailingAnchor.constraint(equalTo: foodItemsNameLabel.trailingAnchor),
            foodItemPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(group: Food, item: FoodItem) {
        //foodGroupsNameLabel.text = "Food Group: \(group.name)"
        //foodGroupsDescriptionLabel.text = group.description
        //foodGroupsIdLabel.text = "Group ID: \(group.id)"
        foodItemsNameLabel.text = "Item Name: \(item.name)"
        //foodItemsDescriptionLabel.text = item.description
        //foodItemsIdLabel.text = "Item ID: \(item.id)"
        foodItemWeightLabel.text = "Weight: \(item.weight)g"
        foodItemPriceLabel.text = "Price: $\(item.price)"
        
        Task {
            let image = await ImageDownloader.shared.getImage(url: item.image_url)
            foodItemImageView.image = image
        }
    }
}
