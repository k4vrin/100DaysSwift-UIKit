//
//  DetailViewController.swift
//  ShareTheFlag
//
//  Created by Mostafa Hosseini on 9/18/23.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))


        if let imgToLoad = selectedImage {
            imageView.image = UIImage(named: imgToLoad)
//            imageView.contentMode = .scaleAspectFill
        }
        view.backgroundColor = .lightGray
    }
    

    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }

        let vc = UIActivityViewController(activityItems: [image, selectedImage ?? "image"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}
