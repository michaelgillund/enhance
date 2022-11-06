//
//  Proxies.swift
//  Enhance
//
//  Created by Michael Gillund on 8/16/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import SPAlert

class Proxies: UIViewController, UITextViewDelegate {
    
    let plusButton = UIButton(type: .system)
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "ENTER PROXIES:"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let textView: UITextView = {
        let view = UITextView()
        view.backgroundColor = UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.00)
        view.textColor = .white
        view.tintColor = .white
        view.cornerRadius = 10
        view.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = .label
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "Proxies"
        
        textView.text = UserDefaults.standard.string(forKey: "proxies") ?? ""
        
        constraints()
        plusBtn()
        
        self.textView.delegate = self
        textView.shadowView()
    }
    func constraints(){
        view.addSubview(label)
        view.addSubview(textView)
        
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        label.bottomAnchor.constraint(equalTo: textView.topAnchor, constant: -8).isActive = true
        
        textView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 0).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    func plusBtn(){
        let xImage = UIImage(systemName: "plus")?.applyingSymbolConfiguration(.init(pointSize: 15, weight: .heavy))
        plusButton.setImage(xImage, for: .normal)
        
        let barItem = UIBarButtonItem(customView: plusButton)
        navigationItem.rightBarButtonItem = barItem
        
        plusButton.addTarget(self, action: #selector(save), for: .touchUpInside)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.backgroundColor = UIColor.white.withAlphaComponent(0.7)
        plusButton.layer.cornerRadius = 17.5
        plusButton.tintColor = UIColor.black.withAlphaComponent(0.7)

        NSLayoutConstraint.activate([
        plusButton.widthAnchor.constraint(equalToConstant: 35),
        plusButton.heightAnchor.constraint(equalToConstant: 35),
        ])
    }
    @objc func save(_ sender: Any) {
        UserDefaults.standard.set(textView.text!, forKey: "proxies")
        
        SPAlert.present(title: "Success", preset: .done)
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
