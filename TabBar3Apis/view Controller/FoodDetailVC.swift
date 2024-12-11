//
//  FoodDetailVC.swift
//  TabBar3Apis
//
//  Created by Srikanth Kyatham on 12/11/24.
//

import UIKit

class FoodDetailVC: UIViewController {
    
    private let foodGroup: Food
    private let foodItem: FoodItem
    
    private let imageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let groupLabel = UILabel()
    private let itemDetailsLabel = UILabel()
    
    init(foodGroup: Food, foodItem: FoodItem) {
        self.foodGroup = foodGroup
        self.foodItem = foodItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        groupLabel.translatesAutoresizingMaskIntoConstraints = false
        itemDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        descriptionLabel.numberOfLines = 0
        groupLabel.numberOfLines = 0
        itemDetailsLabel.numberOfLines = 0
        
        view.addSubview(imageView)
        view.addSubview(descriptionLabel)
        view.addSubview(groupLabel)
        view.addSubview(itemDetailsLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            groupLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            groupLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            groupLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            
            itemDetailsLabel.topAnchor.constraint(equalTo: groupLabel.bottomAnchor, constant: 10),
            itemDetailsLabel.leadingAnchor.constraint(equalTo: groupLabel.leadingAnchor),
            itemDetailsLabel.trailingAnchor.constraint(equalTo: groupLabel.trailingAnchor),
            itemDetailsLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -10)
        ])
        
        Task {
            let image = await ImageDownloader.shared.getImage(url: foodItem.image_url)
            imageView.image = image
        }
        
        descriptionLabel.text = "Description: \(foodItem.description)"
        groupLabel.text = "Group: \(foodGroup.name)"
        itemDetailsLabel.text = "Weight: \(foodItem.weight)g\nPrice: $\(foodItem.price)"
    }
}

