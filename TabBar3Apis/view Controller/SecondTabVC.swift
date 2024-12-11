import UIKit

class SecondTabVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView = UITableView()
    private var arrFoodData: [Food] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        fetchDataFromServer()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FoodCell.self, forCellReuseIdentifier: FoodCell.identifier)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchDataFromServer() {
        Task {
            do {
                let foodData = try await NetworkManager.shared.fetchData(from: "https://raw.githubusercontent.com/shobhakartiwari/shobhakar_api_collections/39b4ed9c85833857e7d21c23352bb4857a818919/FoodData.json", responseType: FoodData.self)
                arrFoodData = foodData.food_groups
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Failed to fetch data: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Table View Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrFoodData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFoodData[section].food_items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FoodCell.identifier, for: indexPath) as! FoodCell
        let foodGroup = arrFoodData[indexPath.section]
        let foodItem = foodGroup.food_items[indexPath.row]
        cell.configure(group: foodGroup, item: foodItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrFoodData[section].name
    }
    //MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let foodGroup = arrFoodData[indexPath.section]
        let foodItem = foodGroup.food_items[indexPath.row]
        let detailVC = FoodDetailVC(foodGroup: foodGroup, foodItem: foodItem)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}



