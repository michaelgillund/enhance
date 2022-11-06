//
//  DashboardCell.swift
//  Enhance
//
//  Created by Michael Gillund on 8/14/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//
import UIKit

class DashboardCell: UICollectionViewCell {

    var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .center
        image.backgroundColor = .clear
        image.layer.cornerRadius = 8
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .link
        contentView.cornerRadius = 8
        
        contentView.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
