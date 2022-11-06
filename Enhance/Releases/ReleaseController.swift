//
//  ReleaseController.swift
//  Enhance
//
//  Created by Michael Gillund on 7/29/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//
import UIKit
import Firebase

class ReleaseController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UIScrollViewDelegate{
    
    private var release = [Releases]()
    private var collectionRef: CollectionReference!
    private var dataBase = Firestore.firestore()
    private let pageControl = UIPageControl()
    var timer = Timer()
    
    let releaseLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.text = "Releases"
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let timeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ReleaseCell.self, forCellWithReuseIdentifier: "ReleaseCell")
        collection.isPagingEnabled = true
        collection.backgroundColor = UIColor.clear
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()
    let analyticsLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.text = "Analytics"
        label.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
//        firebaseData()
        timer = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(ReleaseController.DateandTime), userInfo: nil, repeats: true)
        self.navigationItem.title = "Releases"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always

        constraints()

        collectionView.delegate = self
        collectionView.dataSource = self
        navBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        firebaseData()
    }
    func navBar(){
        let navigationView = UIView()
        self.navigationItem.titleView = navigationView
        if let navigationBar = self.navigationController?.navigationBar {
           navigationBar.addSubview(timeLabel)
            timeLabel.topAnchor.constraint(equalTo: navigationBar.topAnchor, constant: 0).isActive = true
            timeLabel.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor, constant: 16).isActive = true // set the constant how do you prefer
            timeLabel.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -16).isActive = true
            timeLabel.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -20).isActive = true
            timeLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
    @objc func DateandTime(){
        let template = "EEEEdMMMM"

        let format = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: NSLocale.current)
        let formatter = DateFormatter()
        formatter.dateFormat = format

        let now = Date()
        let date = formatter.string(from: now)
        
        timeLabel.text = date.uppercased()
    }
    func constraints(){
//        view.addSubview(timeLabel)
//        view.addSubview(releaseLabel)
        view.addSubview(collectionView)
        view.addSubview(pageControl)
//        view.addSubview(analyticsLabel)
//        timeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
//        timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
//        timeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
//        timeLabel.bottomAnchor.constraint(equalTo: releaseLabel.topAnchor, constant: 0).isActive = true
//
//        releaseLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 0).isActive = true
//        releaseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
//        releaseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
//        releaseLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: 0).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 260).isActive = true
        
        if #available(iOS 14.0, *) {
            pageControl.backgroundStyle = .prominent
            pageControl.allowsContinuousInteraction = true
        } else {
            pageControl.pageIndicatorTintColor = .lightGray
            pageControl.currentPageIndicatorTintColor = .white
        }
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 0).isActive = true
        pageControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 90).isActive = true
        pageControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90).isActive = true

//        analyticsLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 5).isActive = true
//        analyticsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
//        analyticsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
//        analyticsLabel.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: 0).isActive = true
     }

    func firebaseData(){
        dataBase.collection("updates").addSnapshotListener { (snapshot, error) in
            if let err = error {
                debugPrint("Error: \(err)")
            }else {
                self.release = []
                guard  let snap = snapshot else {return}
                for document in snap.documents {
                    let data = document.data()
                    let title = data["title"] as? String
                    let date = data["date"] as? String
                    let price = data["price"] as? String
                    let color = data["color"] as? String
                    let image = data["image"] as? String ?? "https://stockx-assets.imgix.net/media/New-Product-Placeholder-Default.jpg?fit=fill&bg=FFFFFF&w=700&h=500&auto=format,compress&q=90&trim=color&updated_at=false&w=1000"

                    let newRelease = Releases(title: title, date: date, price: price, color: color, image: image)
                    self.release.append(newRelease)
                    }
                self.collectionView.reloadData()
            }
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint) {
            self.pageControl.currentPage = visibleIndexPath.row
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
       pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
       pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = release.count

        pageControl.numberOfPages = count
        pageControl.isHidden = !(count > 1)

        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReleaseCell", for: indexPath) as? ReleaseCell{
            cell.configureCell(release: release[indexPath.row])
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
