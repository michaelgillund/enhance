//
//  SupremeMonitorCell.swift
//  Enhance
//
//  Created by Michael Gillund on 9/17/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//
import UIKit
import MarqueeLabel

class SupremeMonitorCell: UITableViewCell{
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        view.cornerRadius = 10
        view.shadowView()
        view.translatesAutoresizingMaskIntoConstraints = false
            
        return view
    }()
    let productImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    var nameLabel: MarqueeLabel = {
        let label = MarqueeLabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let idLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(mainView)
        contentView.addSubview(productImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(priceLabel)
        
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        productImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
        productImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
//        productImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        productImage.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10).isActive = true
        productImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor, constant: 0).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
//        idLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
//        idLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10).isActive = true
//        idLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0).isActive = true
//        idLabel.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor, constant: 0).isActive = true
//        idLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        categoryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
        categoryLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: 0).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 0).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: productImage.trailingAnchor, constant: 10).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
