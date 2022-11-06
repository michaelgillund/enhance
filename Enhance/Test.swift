//
//  Test.swift
//  Enhance
//
//  Created by Michael Gillund on 9/2/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//
//
//import UIKit
//import Firebase
//import Alamofire
//import SwiftyJSON
//import CollectionViewPagingLayout
//import Randient
//
//class MyCell: UICollectionViewCell{
//
//    var cardLabel: UILabel = {
//        let label = UILabel()
//        label.text = ""
//        label.textColor = .white
//        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    var indexLabel: UILabel = {
//        let label = UILabel()
//        label.text = ""
//        label.textColor = .white
//        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    var nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = ""
//        label.textColor = .white
//        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "Chip.png")
//        imageView.contentMode = .scaleAspectFit
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//     }()
//    let edit: UIButton = {
//        let button = UIButton(type: .custom)
//        let image = UIImage(systemName: "ellipsis")?.applyingSymbolConfiguration(.init(pointSize: 25, weight: .semibold))
//        button.addTarget(self, action: #selector(onEditProfile), for: .touchUpInside)
//        button.isUserInteractionEnabled = true
//        button.setImage(image, for: .normal)
//        button.tintColor = .white
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setup()
//    }
//
//    func setup() {
//        let randient = RandientView()
//        randient.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
//        randient.cornerRadius = 12
//        contentView.addSubview(randient)
//        randient.randomize(animated: true)
//
//        let edit = UIButton(type: .custom)
//        let image = UIImage(systemName: "ellipsis")?.applyingSymbolConfiguration(.init(pointSize: 25, weight: .semibold))
//        edit.addTarget(self, action: #selector(onEditProfile), for: .touchUpInside)
//        edit.isUserInteractionEnabled = true
//        edit.setImage(image, for: .normal)
//        edit.tintColor = .white
//        edit.translatesAutoresizingMaskIntoConstraints = false
//
//        contentView.addSubview(edit)
//        randient.addSubview(indexLabel)
//        randient.addSubview(nameLabel)
//        randient.addSubview(cardLabel)
//        randient.addSubview(imageView)
//
//        NSLayoutConstraint.activate([
//            nameLabel.leadingAnchor.constraint(equalTo: randient.leadingAnchor, constant: 10),
//            nameLabel.trailingAnchor.constraint(equalTo: randient.trailingAnchor, constant: -10),
//            nameLabel.bottomAnchor.constraint(equalTo: randient.bottomAnchor, constant: -15),
//
//            cardLabel.leadingAnchor.constraint(equalTo: randient.leadingAnchor, constant: 10),
//            cardLabel.trailingAnchor.constraint(equalTo: randient.trailingAnchor, constant: -10),
//            cardLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -10),
//
//            indexLabel.trailingAnchor.constraint(equalTo: randient.trailingAnchor, constant: -10),
//            indexLabel.bottomAnchor.constraint(equalTo: randient.bottomAnchor, constant: -10),
//
//            edit.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            edit.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//
//            imageView.topAnchor.constraint(equalTo: randient.topAnchor, constant: 10),
//            imageView.leadingAnchor.constraint(equalTo: randient.leadingAnchor, constant: 10),
//            imageView.heightAnchor.constraint(equalToConstant: 25),
//            imageView.widthAnchor.constraint(equalToConstant: 25),
//        ])
//    }
//
//    var editProfileHandler:(()->Void)?
//    var deleteProfileHandler:(()->Void)?
//    weak var vc: Test2?
//    @objc func onEditProfile(_ sender: UIButton) {
//        let alert = UIAlertController(title: "Edit Profile", message: "Edit & Delete Profiles", preferredStyle: .actionSheet)
//
//        alert.addAction(UIAlertAction(title: "Edit", style: .default , handler:{ (UIAlertAction)in
//            self.editProfileHandler?()
//        }))
//
//        alert.addAction(UIAlertAction(title: "Delete", style: .destructive , handler:{ (UIAlertAction)in
//            self.deleteProfileHandler?()
//        }))
//
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
//
//        }))
//
//
//        //uncomment for iPad Support
////        alert.popoverPresentationController?.sourceView = self.view
//        vc?.present(alert, animated: true, completion: {
//
//        })
//
//    }
//
//    var item: Profile? {
//        didSet {
//            let last4 = item!.card.suffix(4)
//            cardLabel.text = "**** **** **** \(last4)"
//            nameLabel.text = "\(item!.firstName) \(item!.lastName)"
//        }
//    }
//}

// A simple View Controller that filled with a UICollectionView
// You can use `UICollectionViewController` too
//class Test2: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
//    
//
//    fileprivate let collectionView:UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
////        layout.minimumInteritemSpacing = 0
////        layout.minimumLineSpacing = 0
//        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collection.translatesAutoresizingMaskIntoConstraints = false
//        collection.register(MyCell.self, forCellWithReuseIdentifier: "cell")
//        collection.showsVerticalScrollIndicator = false
//        collection.showsHorizontalScrollIndicator = false
////        collection.isPagingEnabled = true
//        collection.backgroundColor = .clear
//        collection.showsHorizontalScrollIndicator = false
//        return collection
//    }()
//    var profiles = Profiles()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
//        self.navigationItem.title = "Profiles"
////        self.navigationItem.backButtonTitle = ""
//        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.00, green: 0.38, blue: 0.97, alpha: 1.00)
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.largeTitleDisplayMode = .always
//        
//        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(add))
//        navigationItem.rightBarButtonItems = [addButton]
//        
//        let doneButton = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .done, target: self, action: #selector(done))
//        navigationItem.leftBarButtonItems = [doneButton]
//        setupCollectionView()
//        if let profiles = Preferences.shared.profiles {
//            self.profiles = profiles
//        }
////        print("PROFILES:", self.profiles.profileList[1])
//    }
//    
//    private func setupCollectionView() {
//
//        collectionView.dataSource = self
//        collectionView.delegate = self
//
//        view.addSubview(collectionView)
//        
//        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
////        collectionView.heightAnchor.constraint(equalToConstant: 350).isActive = true
//    }
//    func saveProfile(_ vc: AddProfile, _ new: Bool, _ index: Int) {
//
//        var profile = Profile()
//        profile.firstName = vc.firstNameText.text!
//        profile.lastName = vc.lastNameText.text!
//        profile.email = vc.emailText.text!
//        profile.telephone = vc.telephoneText.text!
//        profile.addressLine1 = vc.address1Text.text!
//        profile.addressLine2 = vc.address2Text.text!
//        profile.city = vc.cityText.text!
//        profile.state = vc.stateText.text!
//        profile.zipcode = vc.zipcodeText.text!
//        profile.country = vc.countryText.text!
//        profile.cardName = vc.cardNameText.text!
//        profile.cardType = vc.cardTypeText.text!
//        profile.card = vc.cardText.text!
//        profile.month = vc.monthText.text!
//        profile.year = vc.yearText.text!
//        profile.cvv = vc.cvvText.text!
//        
//
//        if new {
//            profiles.profileList.append(profile)
//        } else {
//            profiles.profileList[index] = profile
//        }
//
//        collectionView.reloadData()
//    }
//    @objc func add(){
//        let vc = AddProfile()
//
//        vc.saveProfileHandler = {[weak self] in
//
//            guard let _self = self else { return }
//            _self.saveProfile(vc, true, 0)
//            vc.dismiss(animated: true, completion: nil)
//        }
//        // Just show the view controller
//        present(vc, animated: true, completion: nil)
//    }
//    @objc func done(){
//        Preferences.shared.profiles = self.profiles
//        dismiss(animated: true, completion: nil)
//        
//    }
////    override func viewDidLayoutSubviews() {
////        super.viewDidLayoutSubviews()
////        collectionView.performBatchUpdates({
////            self.collectionView.collectionViewLayout.invalidateLayout()
////        })
////    }
//    
//    func collectionView(_ collectionView: UICollectionView,numberOfItemsInSection section: Int) -> Int {
//        return self.profiles.profileList.count
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: (view.frame.width / 2) - 15, height: 125)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView,cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",for: indexPath) as! MyCell
//        
//        cell.indexLabel.text = "\(indexPath.row + 1)"
//        cell.item = self.profiles.profileList[indexPath.item]
//        
//        cell.editProfileHandler = {[weak self] in
//
//            guard let _self = self else { return }
//            
//            let vc = AddProfile()
//            vc.saveProfileHandler = {
//                _self.saveProfile(vc, false, indexPath.item)
//                vc.dismiss(animated: true, completion: nil)
//            }
//            _self.present(vc, animated: true, completion: nil)
//            
//            vc.item = cell.item
//        }
//        cell.deleteProfileHandler = {[weak self] in
//            guard let _self = self else { return }
//        
//            _self.profiles.profileList.remove(at: indexPath.item)
//            _self.collectionView.reloadData()
//
//        }
//        cell.edit.tag = indexPath.row
//        cell.vc = self
//        return cell
//    }
//  
//}

//
//class MyCell: UICollectionViewCell {
//
//    private let mainView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .systemBackground
//        view.cornerRadius = 8
//        view.translatesAutoresizingMaskIntoConstraints = false
//
//        return view
//    }()
//    private let bottomView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.label.withAlphaComponent(0.7)
//        view.cornerRadius = 8
//        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//    private let productImageView: UIImageView = {
//        let image = UIImageView()
//        image.contentMode = .scaleAspectFit
//        image.backgroundColor = .white
//        image.layer.cornerRadius = 8
//        image.layer.masksToBounds = true
//        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        image.translatesAutoresizingMaskIntoConstraints = false
//        return image
//    }()
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .systemBackground
//        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    private let dateLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .systemBackground
//        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    private let priceLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    private let colorLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .systemBackground
//        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setup()
//    }
//    func configureCell(release: Releases){
//        self.titleLabel.text = release.title
//        self.dateLabel.text = release.date
//        self.priceLabel.text = release.price
//        self.colorLabel.text = release.color
//        let url = URL(string: release.image!)
//        self.productImageView.load(url: url!)
//    }
//    func setup(){
//        contentView.addSubview(mainView)
//        contentView.addSubview(productImageView)
//        contentView.addSubview(bottomView)
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(dateLabel)
//        contentView.addSubview(priceLabel)
//        contentView.addSubview(colorLabel)
//        
//        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
//        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
//        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
//        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
//        
//        productImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0).isActive = true
//        productImageView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0).isActive = true
//        productImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0).isActive = true
//        productImageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0).isActive = true
//
//        bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
//        bottomView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
//        bottomView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
//        bottomView.heightAnchor.constraint(equalToConstant: 70).isActive = true
//
//        titleLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 8).isActive = true
//        titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: 0).isActive = true
//        titleLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10).isActive = true
//        titleLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
//
//        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
//        dateLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -8).isActive = true
//        dateLabel.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10).isActive = true
//        dateLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10).isActive = true
//        dateLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
//
//        priceLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8).isActive = true
//        priceLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -10).isActive = true
//        priceLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
//
//        colorLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -8).isActive = true
//        colorLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -8).isActive = true
//        colorLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
//    }
//
//}
//
//class Test: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UIScrollViewDelegate {
//    
//
//    private var release = [Releases]()
//    private var collectionRef: CollectionReference!
//    private var dataBase = Firestore.firestore()
//    private let pageControl = UIPageControl()
//    
//    let releaseLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = .clear
//        label.textColor = .white
//        label.text = "Releases"
//        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    fileprivate let collectionView:UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collection.translatesAutoresizingMaskIntoConstraints = false
//        collection.register(MyCell.self, forCellWithReuseIdentifier: "MyCell")
//        collection.isPagingEnabled = true
//        collection.backgroundColor = UIColor.clear
//        collection.showsHorizontalScrollIndicator = false
//        return collection
//    }()
//    let analyticsLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = .clear
//        label.textColor = .white
//        label.text = "Analytics"
//        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor(red: 0.09, green: 0.09, blue: 0.11, alpha: 1.00)
//        
//        self.navigationItem.title = "Releases"
//        self.navigationController?.navigationBar.tintColor = .white
//        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        self.navigationItem.largeTitleDisplayMode = .always
//
//        constraints()
//        
//        collectionView.delegate = self
//        collectionView.dataSource = self
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        firebaseData()
//    }
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
//    func constraints(){
//
//        view.addSubview(collectionView)
//        view.addSubview(pageControl)
////        view.addSubview(analyticsLabel)
//        
//        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
//        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
//        collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: 0).isActive = true
//        collectionView.heightAnchor.constraint(equalToConstant: 240).isActive = true
//        
//        if #available(iOS 14.0, *) {
//            pageControl.backgroundStyle = .prominent
//        } else {
//            pageControl.pageIndicatorTintColor = .lightGray
//            pageControl.currentPageIndicatorTintColor = .white
//        }
//        pageControl.translatesAutoresizingMaskIntoConstraints = false
//        pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0).isActive = true
//        pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90).isActive = true
//        pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90).isActive = true
//
////        analyticsLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 5).isActive = true
////        analyticsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
////        analyticsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
////        analyticsLabel.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: 0).isActive = true
//     }
//
//    func firebaseData(){
//        dataBase.collection("updates").addSnapshotListener { (snapshot, error) in
//            if let err = error {
//                debugPrint("Error: \(err)")
//            }else {
//                self.release = []
//                guard  let snap = snapshot else {return}
//                for document in snap.documents {
//                    let data = document.data()
//                    let title = data["title"] as? String
//                    let date = data["date"] as? String
//                    let price = data["price"] as? String
//                    let color = data["color"] as? String
//                    let image = data["image"] as? String ?? "https://stockx-assets.imgix.net/media/New-Product-Placeholder-Default.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&trim=color&updated_at=false&w=1000"
//
//                    let newRelease = Releases(title: title, date: date, price: price, color: color, image: image)
//                    self.release.append(newRelease)
//                    }
//                self.collectionView.reloadData()
//            }
//        }
//    }
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
//        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
//        if let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint) {
//            self.pageControl.currentPage = visibleIndexPath.row
//        }
//    }
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//       pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//        
//    }
//    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//       pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
//        
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        let count = release.count
//
//        pageControl.numberOfPages = count
//        pageControl.isHidden = !(count > 1)
//
//        return count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? MyCell{
//            cell.configureCell(release: release[indexPath.row])
//            return cell
//        }else{
//            return UICollectionViewCell()
//        }
//    }
//}
