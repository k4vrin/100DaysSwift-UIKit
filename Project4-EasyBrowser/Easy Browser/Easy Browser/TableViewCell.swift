//
//  TableViewCell.swift
//  Easy Browser
//
//  Created by Mostafa Hosseini on 11/5/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    var logoImageView = UIImageView()
    var titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(logoImageView)
        addSubview(titleLabel)
        
        configureImageView()
        configureTitleLabel()
        setImageConstraints()
        setTitleLabelConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(image: UIImage? = nil, label: String) {
        logoImageView.image = image
        titleLabel.text = label
    }
    
    private func configureImageView() {
        logoImageView.layer.cornerRadius = 10
        logoImageView.clipsToBounds = true
    }
    
    private func configureTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func setImageConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: 16 / 9).isActive = true
    }
    
    private func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
}
