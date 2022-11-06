//
//  MessageCell.swift
//  Enhance
//
//  Created by Michael Gillund on 5/18/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import ActiveLabel

class MessageCell: UITableViewCell {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblMsg: ActiveLabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblSenderName: UILabel!
    
//    let viewContainer: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    let messageLabel: ActiveLabel = {
//        let label = ActiveLabel()
//        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    let dateLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    let senderLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.addSubview(viewContainer)
//        contentView.addSubview(messageLabel)
//        contentView.addSubview(dateLabel)
//        contentView.addSubview(senderLabel)
//        
//        viewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -5).isActive = true
//        viewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5).isActive = true
//        viewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
//        viewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
//
//        messageLabel.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 0).isActive = true
//        messageLabel.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: 0).isActive = true
//        messageLabel.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 0).isActive = true
//        messageLabel.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: 0).isActive = true
//        messageLabel.heightAnchor.constraint(equalToConstant: 300).isActive = true
//        dateLabel.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 5).isActive = true
//        dateLabel.bottomAnchor.constraint(equalTo: senderLabel.topAnchor, constant: 5).isActive = true
//        dateLabel.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 0).isActive = true
//        dateLabel.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: 0).isActive = true
//        dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
//
//        senderLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5).isActive = true
//        senderLabel.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: 0).isActive = true
//        senderLabel.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 0).isActive = true
//        senderLabel.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: 0).isActive = true
//        senderLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}

