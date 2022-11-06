//
//  ListCell.swift
//  Enhance
//
//  Created by Michael Gillund on 5/18/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThickMaterial)
        let visualEffect = UIVisualEffectView(effect: blurEffect)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        return visualEffect
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(visualEffectView)
        contentView.addSubview(titleLabel)
        
        visualEffectView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        visualEffectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: visualEffectView.topAnchor, constant: 0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: visualEffectView.bottomAnchor, constant: 0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: visualEffectView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: visualEffectView.trailingAnchor, constant: -16).isActive = true
        
            
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
