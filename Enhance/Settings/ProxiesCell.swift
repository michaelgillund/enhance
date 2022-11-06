//
//  ProxiesCell.swift
//  Enhance
//
//  Created by Michael Gillund on 10/6/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//
import UIKit

class ProxiesCell: UITableViewCell {
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        view.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "Proxy.png")
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Proxies"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let arrowImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "Arrow.png")
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        
        contentView.addSubview(mainView)
        contentView.addSubview(logoImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowImage)
        
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        
        logoImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5).isActive = true
        logoImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = true
        logoImage.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -10).isActive = true
        logoImage.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: arrowImage.leadingAnchor, constant: 0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0).isActive = true
        
        arrowImage.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5).isActive = true
        arrowImage.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 10).isActive = true
        arrowImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = true
        arrowImage.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5).isActive = true
        arrowImage.widthAnchor.constraint(equalToConstant: 25).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
