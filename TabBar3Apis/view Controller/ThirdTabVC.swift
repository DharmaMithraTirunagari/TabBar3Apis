//
//  ThirdTabVC.swift
//  TabBar3Apis
//
//  Created by Srikanth Kyatham on 12/11/24.
//

import UIKit

import UIKit

class ThirdTabVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var persons: [PersonModel] = []
    private let tableView = UITableView()
    private let url = "https://jsonplaceholder.typicode.com/users"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        fetchDataAndUpdateUI()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PersonCell.self, forCellReuseIdentifier: PersonCell.identifier)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    private func fetchDataAndUpdateUI() {
        Task {
            do {
                let fetchedPersons = try await NetworkManager.shared.fetchData(from: url, responseType: [PersonModel].self)
                DispatchQueue.main.async {
                    self.persons = fetchedPersons
                    self.tableView.reloadData()
                }
            } catch {
                print("Failed to fetch person data: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.identifier, for: indexPath) as! PersonCell
        let person = persons[indexPath.row]
        cell.config(from: person)
        return cell
    }
    
    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPerson = persons[indexPath.row]
        let detailVC = PersonDetailViewController(person: selectedPerson)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

