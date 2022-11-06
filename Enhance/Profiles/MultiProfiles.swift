//
//  Profiles.swift
//  Enhance
//
//  Created by Michael Gillund on 11/7/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//
import UIKit

class MultiProfiles: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    

    fileprivate let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(MultiProfileCell.self, forCellWithReuseIdentifier: "MultiProfileCell")
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
//        collection.isPagingEnabled = true
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    var profiles = Profiles()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.isModalInPresentation = true
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        self.navigationItem.title = "Profiles"
//        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(add))
        navigationItem.rightBarButtonItems = [addButton]
        
        let doneButton = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .done, target: self, action: #selector(done))
        navigationItem.leftBarButtonItems = [doneButton]
        setupCollectionView()
        if let profiles = Preferences.shared.profiles {
            self.profiles = profiles
        }
        print("PROFILES:", self.profiles.profileList)
    }

    private func setupCollectionView() {

        collectionView.dataSource = self
        collectionView.delegate = self

        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//        collectionView.heightAnchor.constraint(equalToConstant: 350).isActive = true
    }
    func saveProfile(_ vc: AddProfile, _ new: Bool, _ index: Int) {

        var profile = Profile()
        profile.firstName = vc.firstNameText.text!
        profile.lastName = vc.lastNameText.text!
        profile.email = vc.emailText.text!
        profile.telephone = vc.telephoneText.text!
        profile.addressLine1 = vc.address1Text.text!
        profile.addressLine2 = vc.address2Text.text!
        profile.city = vc.cityText.text!
        profile.state = vc.stateText.text!
        profile.zipcode = vc.zipcodeText.text!
        profile.country = vc.countryText.text!
        profile.cardName = vc.cardNameText.text!
        profile.cardType = vc.cardTypeText.text!
        profile.card = vc.cardText.text!
        profile.month = vc.monthText.text!
        profile.year = vc.yearText.text!
        profile.cvv = vc.cvvText.text!
        

        if new {
            profiles.profileList.append(profile)
        } else {
            profiles.profileList[index] = profile
        }

        collectionView.reloadData()
    }
    @objc func add(){
        let vc = AddProfile()

        vc.saveProfileHandler = {[weak self] in

            guard let _self = self else { return }
            _self.saveProfile(vc, true, 0)
            vc.dismiss(animated: true, completion: nil)
        }
        // Just show the view controller
        present(vc, animated: true, completion: nil)
    }
    @objc func done(){
        Preferences.shared.profiles = self.profiles
        dismiss(animated: true, completion: nil)
        
    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        collectionView.performBatchUpdates({
//            self.collectionView.collectionViewLayout.invalidateLayout()
//        })
//    }
    
    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
        return self.profiles.profileList.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 15, height: 125)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MultiProfileCell",for: indexPath) as! MultiProfileCell
        
        cell.indexLabel.text = "\(indexPath.row + 1)"
        cell.item = self.profiles.profileList[indexPath.item]
        
        cell.editProfileHandler = {[weak self] in

            guard let _self = self else { return }
            
            let vc = AddProfile()
            vc.saveProfileHandler = {
                _self.saveProfile(vc, false, indexPath.item)
                vc.dismiss(animated: true, completion: nil)
            }
            _self.present(vc, animated: true, completion: nil)
            
            vc.item = cell.item
        }
        cell.deleteProfileHandler = {[weak self] in
            guard let _self = self else { return }
        
            _self.profiles.profileList.remove(at: indexPath.item)
            _self.collectionView.reloadData()

        }
        
        cell.vc = self
        return cell
    }
  
}

