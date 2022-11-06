//
//  AddProfile.swift
//  Enhance
//
//  Created by Michael Gillund on 11/6/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import SPAlert

class AddProfile: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
        hideKeyboardWhenTappedAround()
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
//
//        self.navigationItem.title = "Add Profile"
//        self.navigationItem.backButtonTitle = ""
//        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.00, green: 0.38, blue: 0.97, alpha: 1.00)
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.largeTitleDisplayMode = .always

        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(add))
        navigationItem.rightBarButtonItems = [addButton]
        
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        view.addSubview(buttonView)
        scrollViewContainer.addArrangedSubview(emptyView)
        scrollViewContainer.addArrangedSubview(titleLabel)
        scrollViewContainer.addArrangedSubview(firstNameText)
        scrollViewContainer.addArrangedSubview(lastNameText)
        scrollViewContainer.addArrangedSubview(emailText)
        scrollViewContainer.addArrangedSubview(telephoneText)
        scrollViewContainer.addArrangedSubview(emptyView2)
        scrollViewContainer.addArrangedSubview(address1Text)
        scrollViewContainer.addArrangedSubview(address2Text)
        scrollViewContainer.addArrangedSubview(cityText)
        scrollViewContainer.addArrangedSubview(stateText)
        scrollViewContainer.addArrangedSubview(zipcodeText)
        scrollViewContainer.addArrangedSubview(countryText)
        scrollViewContainer.addArrangedSubview(emptyView3)
        scrollViewContainer.addArrangedSubview(cardNameText)
        scrollViewContainer.addArrangedSubview(cardTypeText)
        scrollViewContainer.addArrangedSubview(cardText)
        scrollViewContainer.addArrangedSubview(monthText)
        scrollViewContainer.addArrangedSubview(yearText)
        scrollViewContainer.addArrangedSubview(cvvText)
        scrollViewContainer.addArrangedSubview(emptyView4)
        
        firstNameText.attributedPlaceholder = NSAttributedString(string:"First Name",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        lastNameText.attributedPlaceholder = NSAttributedString(string:"Last Name",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        emailText.attributedPlaceholder = NSAttributedString(string:"Email",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        telephoneText.attributedPlaceholder = NSAttributedString(string:"Phone Number",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        address1Text.attributedPlaceholder = NSAttributedString(string:"Address 1",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        address2Text.attributedPlaceholder = NSAttributedString(string:"Address 2",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        cityText.attributedPlaceholder = NSAttributedString(string:"City",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        stateText.attributedPlaceholder = NSAttributedString(string:"State",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        zipcodeText.attributedPlaceholder = NSAttributedString(string:"Zip Code",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        countryText.attributedPlaceholder = NSAttributedString(string:"Country",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        cardNameText.attributedPlaceholder = NSAttributedString(string:"Full Name",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        cardTypeText.attributedPlaceholder = NSAttributedString(string:"Card Type",
                                                                attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        cardText.attributedPlaceholder = NSAttributedString(string:"Credit Card",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        monthText.attributedPlaceholder = NSAttributedString(string:"Month",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        yearText.attributedPlaceholder = NSAttributedString(string:"Year",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        cvvText.attributedPlaceholder = NSAttributedString(string:"CVV",
                                                           attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),


            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            // this is important for scrolling
            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            buttonView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            buttonView.heightAnchor.constraint(equalToConstant: 60),
            
            emptyView.heightAnchor.constraint(equalToConstant: 60),
//            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            firstNameText.heightAnchor.constraint(equalToConstant: 50),
            lastNameText.heightAnchor.constraint(equalToConstant: 50),
            emailText.heightAnchor.constraint(equalToConstant: 50),
            telephoneText.heightAnchor.constraint(equalToConstant: 50),
            emptyView2.heightAnchor.constraint(equalToConstant: 50),
            address1Text.heightAnchor.constraint(equalToConstant: 50),
            address2Text.heightAnchor.constraint(equalToConstant: 50),
            cityText.heightAnchor.constraint(equalToConstant: 50),
            stateText.heightAnchor.constraint(equalToConstant: 50),
            zipcodeText.heightAnchor.constraint(equalToConstant: 50),
            countryText.heightAnchor.constraint(equalToConstant: 50),
            emptyView3.heightAnchor.constraint(equalToConstant: 50),
            cardNameText.heightAnchor.constraint(equalToConstant: 50),
            cardTypeText.heightAnchor.constraint(equalToConstant: 50),
            cardText.heightAnchor.constraint(equalToConstant: 50),
            monthText.heightAnchor.constraint(equalToConstant: 50),
            yearText.heightAnchor.constraint(equalToConstant: 50),
            cvvText.heightAnchor.constraint(equalToConstant: 50),
            emptyView4.heightAnchor.constraint(equalToConstant: 250),
        ])
        saveBtn()
        exitBtn()
    }
    var saveProfileHandler:(()->Void)?
        
    var item: Profile? {
        didSet {
            firstNameText.text = item!.firstName
            lastNameText.text = item!.lastName
            emailText.text = item!.email
            telephoneText.text = item!.telephone
            address1Text.text = item!.addressLine1
            address2Text.text = item!.addressLine1
            cityText.text = item!.city
            stateText.text = item!.state
            zipcodeText.text = item!.zipcode
            countryText.text = item!.country
            cardNameText.text = item!.cardName
            cardTypeText.text = item!.cardType
            cardText.text = item!.card
            monthText.text = item!.month
            yearText.text = item!.year
            cvvText.text = item!.cvv

        }
    }
    @objc func add(_ sender: Any){
        saveProfileHandler?()
        SPAlert.present(title:"Success",preset: .done)
    }
    @objc func close(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }
    func saveBtn(){
        let save = UIButton(type: .system)
        let xImage = UIImage(systemName: "plus")?.applyingSymbolConfiguration(.init(pointSize: 20, weight: .semibold))
        save.setImage(xImage, for: .normal)
        
        view.addSubview(save)
        
        save.addTarget(self, action: #selector(add), for: .touchUpInside)
        save.translatesAutoresizingMaskIntoConstraints = false
        save.backgroundColor = UIColor.clear
        save.layer.cornerRadius = 15
        save.tintColor = .white

        NSLayoutConstraint.activate([
            save.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            save.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            save.widthAnchor.constraint(equalToConstant: 30),
            save.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    func exitBtn(){
        let exit = UIButton(type: .system)
        let xImage = UIImage(systemName: "multiply")?.applyingSymbolConfiguration(.init(pointSize: 20, weight: .semibold))
        exit.setImage(xImage, for: .normal)
        
        view.addSubview(exit)
        
        exit.addTarget(self, action: #selector(close), for: .touchUpInside)
        exit.translatesAutoresizingMaskIntoConstraints = false
        exit.backgroundColor = UIColor.clear
        exit.layer.cornerRadius = 15
        exit.tintColor = .white

        NSLayoutConstraint.activate([
            exit.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            exit.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            exit.widthAnchor.constraint(equalToConstant: 30),
            exit.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let scrollViewContainer: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.text = "Add Profile"
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let buttonView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let emptyView2: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let emptyView3: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let emptyView4: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var firstNameText: UITextField = {
        let text = TextField()
        text.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        text.tintColor = .link
        text.textColor = .white
        text.layer.cornerRadius = 5
        text.keyboardType = .default
        text.autocapitalizationType = .none
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var lastNameText: UITextField = {
        let text = TextField()
        text.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        text.tintColor = .link
        text.textColor = .white
        text.layer.cornerRadius = 5
        text.keyboardType = .default
        text.autocapitalizationType = .none
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var emailText: UITextField = {
        let text = TextField()
        text.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        text.tintColor = .link
        text.textColor = .white
        text.layer.cornerRadius = 5
        text.keyboardType = .default
        text.autocapitalizationType = .none
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var telephoneText: UITextField = {
        let text = TextField()
        text.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        text.tintColor = .link
        text.textColor = .white
        text.layer.cornerRadius = 5
        text.keyboardType = .default
        text.autocapitalizationType = .none
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var address1Text: UITextField = {
        let text = TextField()
        text.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        text.tintColor = .link
        text.textColor = .white
        text.layer.cornerRadius = 5
        text.keyboardType = .default
        text.autocapitalizationType = .none
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var address2Text: UITextField = {
        let text = TextField()
        text.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        text.tintColor = .link
        text.textColor = .white
        text.layer.cornerRadius = 5
        text.keyboardType = .default
        text.autocapitalizationType = .none
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var cityText: UITextField = {
        let text = TextField()
        text.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        text.tintColor = .link
        text.textColor = .white
        text.layer.cornerRadius = 5
        text.keyboardType = .default
        text.autocapitalizationType = .none
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var stateText: UITextField = {
        let text = TextField()
        text.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        text.tintColor = .link
        text.textColor = .white
        text.layer.cornerRadius = 5
        text.keyboardType = .default
        text.autocapitalizationType = .none
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var zipcodeText: UITextField = {
        let text = TextField()
        text.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        text.tintColor = .link
        text.textColor = .white
        text.layer.cornerRadius = 5
        text.keyboardType = .default
        text.autocapitalizationType = .none
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var countryText: UITextField = {
        let text = TextField()
        text.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        text.tintColor = .link
        text.textColor = .white
        text.layer.cornerRadius = 5
        text.keyboardType = .default
        text.autocapitalizationType = .none
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var cardNameText: UITextField = {
        let text = TextField()
        text.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        text.tintColor = .link
        text.textColor = .white
        text.layer.cornerRadius = 5
        text.keyboardType = .default
        text.autocapitalizationType = .none
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var cardTypeText: UITextField = {
        let text = TextField()
        text.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        text.tintColor = .link
        text.textColor = .white
        text.layer.cornerRadius = 5
        text.keyboardType = .default
        text.autocapitalizationType = .none
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var cardText: UITextField = {
        let text = TextField()
        text.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        text.tintColor = .link
        text.textColor = .white
        text.layer.cornerRadius = 5
        text.keyboardType = .default
        text.autocapitalizationType = .none
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var yearText: UITextField = {
        let text = TextField()
        text.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        text.tintColor = .link
        text.textColor = .white
        text.layer.cornerRadius = 5
        text.keyboardType = .default
        text.autocapitalizationType = .none
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var monthText: UITextField = {
        let text = TextField()
        text.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        text.tintColor = .link
        text.textColor = .white
        text.layer.cornerRadius = 5
        text.keyboardType = .default
        text.autocapitalizationType = .none
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    var cvvText: UITextField = {
        let text = TextField()
        text.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        text.tintColor = .link
        text.textColor = .white
        text.layer.cornerRadius = 5
        text.keyboardType = .default
        text.autocapitalizationType = .none
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
}
