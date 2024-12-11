//
//  ViewController.swift
//  TabBar3Apis
//
//  Created by Srikanth Kyatham on 12/11/24.
//

import UIKit


class FirstTabVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView =  UITableView()
    var images: [ImageItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpTableView()
        fetchImages()
    }
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImageTableViewCell.self, forCellReuseIdentifier: ImageTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    private func fetchImages() {
            Task {
                do {
                    // Fetch data using NetworkManager
                    let fetchedImages = try await NetworkManager.shared.fetchData(
                        from: "https://jsonplaceholder.typicode.com/photos",
                        responseType: [ImageItem].self
                    )
                    DispatchQueue.main.async {
                        self.images = fetchedImages
                        self.tableView.reloadData()
                    }
                } catch {
                    print("Failed to fetch images: \(error.localizedDescription)")
                }
            }
        }

}

extension FirstTabVC{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as! ImageTableViewCell
        let image = images[indexPath.row]
        cell.configure(with: image )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let image = images[indexPath.row]
        let detailVC = ImageDetailVC(imageItem: image)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

