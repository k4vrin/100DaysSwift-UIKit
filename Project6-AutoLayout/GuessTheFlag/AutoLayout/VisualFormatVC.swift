//
//  VisualFormatVC.swift
//  AutoLayout
//
//  Created by Mostafa Hosseini on 11/27/23.
//

import UIKit

class VisualFormatVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = .red
        label1.text = "THESE"
        label1.sizeToFit()
        view.addSubview(label1)
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = .cyan
        label2.text = "ARE"
        label2.sizeToFit()
        view.addSubview(label2)
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = .yellow
        label3.text = "SOME"
        label3.sizeToFit()
        view.addSubview(label3)
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = .green
        label4.text = "AWESOME"
        label4.sizeToFit()
        view.addSubview(label4)
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = .orange
        label5.text = "LABELS"
        label5.sizeToFit()
        view.addSubview(label5)
        
        let viewsDict = ["label1": label1, "label2": label2, "label3": label3, "label4": label4, "label5": label5]
        
        for label in viewsDict.keys {
            // H -> Horizontal
            // || -> Edge of the parent view. in this case "view"
            // [] -> actual subview
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", metrics: nil, views: viewsDict))
        }
        // - -> 10px space
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[label1]-[label2]-[label3]-[label4]-[label5]", metrics: nil, views: viewsDict))
    }
}
