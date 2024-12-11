//
//  PersonDetailVC.swift
//  TabBar3Apis
//
//  Created by Srikanth Kyatham on 12/11/24.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    private let person: PersonModel
    
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    private let phoneLabel = UILabel()
    private let addressLabel = UILabel()
    private let companyLabel = UILabel()
    
    init(person: PersonModel) {
        self.person = person
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
        let labels = [nameLabel, emailLabel, phoneLabel, addressLabel, companyLabel]
        labels.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.numberOfLines = 0
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            phoneLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            phoneLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 10),
            addressLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            companyLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 10),
            companyLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            companyLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
    }
    
    private func displayDetails() {
        nameLabel.text = "Name: \(person.name ?? "Unknown")"
        emailLabel.text = "Email: \(person.email ?? "Unknown")"
        phoneLabel.text = "Phone: \(person.phone ?? "Unknown")"
        
        if let address = person.address {
            addressLabel.text = """
            Address:
            Street: \(address.street ?? "Unknown")
            Suite: \(address.suite ?? "Unknown")
            City: \(address.city ?? "Unknown")
            Zip: \(address.zipcode ?? "Unknown")
            """
        } else {
            addressLabel.text = "Address: Unknown"
        }
        
        if let company = person.company {
            companyLabel.text = """
            Company:
            Name: \(company.name ?? "Unknown")
            CatchPhrase: \(company.catchPhrase ?? "Unknown")
            BS: \(company.bs ?? "Unknown")
            """
        } else {
            companyLabel.text = "Company: Unknown"
        }
    }
}
