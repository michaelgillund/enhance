//
//  Releases.swift
//  Enhance
//
//  Created by Michael Gillund on 8/20/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

//import UIKit
//
//@available(iOS 14.0, *)
//class ReleasesView: UIView {
//    
//    lazy var collectionView: UICollectionView = {
//        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
//        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
//        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collection.translatesAutoresizingMaskIntoConstraints = false
//        collection.backgroundColor = .systemGroupedBackground
//
//        return collection
//    }()
//    init(){
//        super.init(frame: .zero)
//        setUpSubviews()
//    }
//    func setUpSubviews(){
//        addSubview(collectionView)
//        
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: topAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
//    required init?(coder: NSCoder) {
//        fatalError("INIT ERROR:")
//    }
//    
//}
import UIKit

class ReleasesVC: UIViewController, UICollectionViewDelegate{

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: 230)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemBackground
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ReleasesCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
    }

}
extension ReleasesVC: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReleasesCell", for: indexPath)
        cell.backgroundColor = [.red, .blue, .purple, .gray, .yellow].randomElement()
//        cell.layer.cornerRadius = 15
        return cell
    }
    
    
}
