//
//  ViewController.swift
//  ShopingList
//
//  Created by Mostafa Hosseini on 1/9/24.
//

import UIKit

class ViewController: UITableViewController {
    
    var shopItems = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configBar()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopItem", for: indexPath)
        var config = UIListContentConfiguration.cell()
        config.text = shopItems[indexPath.row]
        cell.contentConfiguration = config
        
        return cell
    }
    
    private func configBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .redo, target: self, action: #selector(clearShopList))
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer)),
            UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareList))
        ]
    }
    
    private func addItem(_ geroceryItem: String) {
        shopItems.insert(geroceryItem, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    @objc private func clearShopList() {
        shopItems.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc private func shareList() {
        let list = shopItems.joined(separator: ", ")
        let act = UIActivityViewController(activityItems: [list], applicationActivities: nil)
        present(act, animated: true)
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Grocery Item", message: "What do you want to buy?", preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.addItem(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }

}
