//
//  ViewController.swift
//  ShareTheFlag
//
//  Created by Mostafa Hosseini on 9/11/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Share The Flag"
        navigationController?.navigationBar.prefersLargeTitles = true
        let path = Bundle.main.resourcePath!
        let items = try! FileManager.default.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".png") {
                flags.append(item)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        var config = UIListContentConfiguration.cell()
        config.text = "\(flags[indexPath.row].dropLast(7))"
        config.image = UIImage(named: flags[indexPath.row])
        config.imageProperties.maximumSize = CGSize(width: 64, height: 48)
        cell.contentConfiguration = config
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
//            vc.selectedImage = pictures[indexPath.row]
//            navigationController?.pushViewController(vc, animated: true)
//        }
//    }

}

