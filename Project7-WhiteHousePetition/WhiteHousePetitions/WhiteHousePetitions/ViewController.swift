//
//  ViewController.swift
//  WhiteHousePetitions
//
//  Created by Mostafa Hosseini on 1/24/24.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let error = error {
                    // handle error
                    print("Error fetching data: \(error)")
                } else if let data = data {
                    DispatchQueue.main.async {
                        self?.parse(json: data)
                    }
                }
                
            }.resume()
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Petition", for: indexPath)
        var config = UIListContentConfiguration.cell()
        config.text = petitions[indexPath.row].title
        config.secondaryText = petitions[indexPath.row].body
          
        cell.contentConfiguration = config
        return cell
    }
}
