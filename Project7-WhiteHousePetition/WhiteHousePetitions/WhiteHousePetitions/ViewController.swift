//
//  ViewController.swift
//  WhiteHousePetitions
//
//  Created by Mostafa Hosseini on 1/24/24.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredPetitions: [Petition] {
        DispatchQueue.global().asyncAndWait {
            petitions.filter { petition in
                return if filterText == "" {
                    true
                } else {
                    petition.title.lowercased().contains(filterText.lowercased())
                }
            }
        }
    }
    var filterText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configBar()
        // Do any additional setup after loading the view.
        
//        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let error = error {
                    // handle error
                    print("Error fetching data: \(error)")
                    DispatchQueue.main.async {
                        self?.showError()
                    }
                    
                } else if let data = data {
                    DispatchQueue.main.async {
                        self?.parse(json: data)
                    }
                }
                
            }.resume()
        } else {
            showError()
        }
    }
    
    private func configBar() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(showCredits)),
            UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease.circle"), style: .plain, target: self, action: #selector(showFilterAlert)),
        ]
    }
    
    @objc private func showCredits() {
        let ac = UIAlertController(title: "Credits", message: "We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc private func showFilterAlert() {
        let ac = UIAlertController(title: "Filter", message: "", preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.filterText = answer
            self?.tableView.reloadData()
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Petition", for: indexPath)
        var config = UIListContentConfiguration.cell()
        config.text = filteredPetitions[indexPath.row].title
        config.secondaryText = filteredPetitions[indexPath.row].body
        config.textProperties.numberOfLines = 1
        config.secondaryTextProperties.numberOfLines = 1
          
        cell.contentConfiguration = config
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
