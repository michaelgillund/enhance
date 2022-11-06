//
//  ReleaseCell.swift
//  Enhance
//
//  Created by Michael Gillund on 7/28/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//
//
import UIKit

class ReleaseCell: UICollectionViewCell {

    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.shadowView()

        return view
    }()
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.85)
//        view.cornerRadius = 10
//        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let productImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .white
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    func configureCell(release: Releases){
        self.titleLabel.text = release.title
        self.dateLabel.text = release.date
        self.priceLabel.text = release.price
        self.colorLabel.text = release.color
        let url = URL(string: release.image!)
        self.productImageView.load(url: url!)
    }
    func setup(){
        contentView.addSubview(mainView)
        contentView.addSubview(productImageView)
        contentView.addSubview(bottomView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(colorLabel)
        
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        productImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0).isActive = true
        productImageView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0).isActive = true
        productImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0).isActive = true
        productImageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0).isActive = true

        bottomView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 70).isActive = true

        titleLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: 0).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true

        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -8).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true

        priceLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true

        colorLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -8).isActive = true
        colorLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -8).isActive = true
        colorLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
    }

}
