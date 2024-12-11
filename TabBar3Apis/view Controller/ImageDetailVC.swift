//
//  ImageDetailVC.swift
//  TabBar3Apis
//
//  Created by Srikanth Kyatham on 12/11/24.
//



import UIKit

class ImageDetailVC: UIViewController {
    
    private let imageItem: ImageItem
    
    private let imageView = UIImageView()
    private let albumIDLabel = UILabel()
    private let idLabel = UILabel()
    private let titleLabel = UILabel()
    
    init(imageItem: ImageItem) {
        self.imageItem = imageItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        displayDetails()
    }
    
    private func setupUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        albumIDLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        let labels = [albumIDLabel, idLabel, titleLabel]
        labels.forEach {
            $0.numberOfLines = 0
            view.addSubview($0)
        }
        
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            // ImageView occupies half of the screen
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            // AlbumID Label
            albumIDLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            albumIDLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            albumIDLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // ID Label
            idLabel.topAnchor.constraint(equalTo: albumIDLabel.bottomAnchor, constant: 10),
            idLabel.leadingAnchor.constraint(equalTo: albumIDLabel.leadingAnchor),
            idLabel.trailingAnchor.constraint(equalTo: albumIDLabel.trailingAnchor),
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: albumIDLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: albumIDLabel.trailingAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    private func displayDetails() {
        Task {
            let image = await ImageDownloader.shared.getImage(url: imageItem.url)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        
        albumIDLabel.text = "Album ID: \(imageItem.id)"
        idLabel.text = "ID: \(imageItem.id)"
        titleLabel.text = "Title: \(imageItem.title)"
    }
}
