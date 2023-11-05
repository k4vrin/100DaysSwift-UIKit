//
//  InitialViewController.swift
//  Easy Browser
//
//  Created by Mostafa Hosseini on 11/5/23.
//

import UIKit

class InitialViewController: UIViewController {
    var websites = ["www.apple.com", "www.hackingwithswift.com"]
    var tableView = UITableView()
    
    enum Cells {
        static let websiteCell = "WebsiteCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: Cells.websiteCell)
        title = "Easy Browser"
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        setTableViewDelegates()
        tableView.rowHeight = 56
        tableView.pin(to: view)
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension InitialViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.websiteCell, for: indexPath) as! TableViewCell
        cell.set(label: "\(websites[indexPath.row])")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewController(selectedWebsite: websites[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
}
