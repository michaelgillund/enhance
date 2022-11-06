//
//  UserCell.swift
//  Enhance
//
//  Created by Michael Gillund on 9/14/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    private let userImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "Logo.png")
        image.backgroundColor = .clear
        image.layer.cornerRadius = 40
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Hello, Moon"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
//        label.lineBreakMode = .byWordWrapping
//        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "michaelgillund@gmail.com"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let verifiedLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.00, green: 0.38, blue: 0.97, alpha: 1.00)
//        label.backgroundColor = UIColor(red: 0.00, green: 0.38, blue: 0.97, alpha: 1.00)
        label.text = "VERIFIED"
//        label.cornerRadius = 9
//        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear

        contentView.addSubview(userImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(emailLabel)
        contentView.addSubview(verifiedLabel)
        
        userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        userImage.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: -20).isActive = true
        userImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: emailLabel.topAnchor, constant: 0).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 20).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        emailLabel.bottomAnchor.constraint(equalTo: verifiedLabel.topAnchor, constant: -5).isActive = true
//        emailLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        verifiedLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5).isActive = true
        verifiedLabel.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 20).isActive = true
//        verifiedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        verifiedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
