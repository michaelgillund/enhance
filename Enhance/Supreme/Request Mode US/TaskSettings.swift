//
//  TaskSettings.swift
//  Enhance
//
//  Created by Michael Gillund on 6/1/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit
import SafariServices

class TaskSettings: UITableViewController, UITextFieldDelegate, SFSafariViewControllerDelegate{

    @IBOutlet weak var keywords1: UITextField!
    @IBOutlet weak var category1: UITextField!
    @IBOutlet weak var size1: UITextField!
    @IBOutlet weak var color1: UITextField!
    
    @IBOutlet weak var timeLbl: UILabel!
    

        
        var pickerView = UIPickerView()
        var currentTextField = UITextField()

        var categories = [String]()
        var sizes = [String]()
        var locations = [String]()
        var savedTasks = [String]()
        
        var time = Timer()
    
    var index = 0
    var section = 0
    let safariButton = UIButton(type: .system)
        
        let defaults = UserDefaults.standard

        override func viewDidLoad() {
            super.viewDidLoad()
            hideKeyboardWhenTappedAround()
            
            view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.05, alpha: 1.00)

            setupTextFields()
            createPickerView()
            time = Timer.scheduledTimer(timeInterval: 0, target: self, selector: #selector(TaskSettings.DateandTime), userInfo: nil, repeats: true)
            safariBtn()
  
        }
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(true)
            setupArrays()
        }
        @objc func DateandTime(){
            let currentDateTime = Date()
            let formatter = DateFormatter()
            
            formatter.timeStyle = .medium
            formatter.dateStyle = .none
            
            timeLbl.text = formatter.string(from: currentDateTime)
           }
        func textFieldDidBeginEditing(_ textField: UITextField) {
            currentTextField = textField
            pickerView.selectRow(0, inComponent: 0, animated: false)
        }
    func safariBtn(){
        let xImage = UIImage(systemName: "safari")?.applyingSymbolConfiguration(.init(pointSize: 15, weight: .heavy))
        safariButton.setImage(xImage, for: .normal)
        
        let barItem = UIBarButtonItem(customView: safariButton)
        navigationItem.rightBarButtonItem = barItem
        
        safariButton.addTarget(self, action: #selector(start), for: .touchUpInside)
        safariButton.translatesAutoresizingMaskIntoConstraints = false
        safariButton.backgroundColor = UIColor.label.withAlphaComponent(0.7)
        safariButton.layer.cornerRadius = 20
        safariButton.tintColor = UIColor.systemBackground.withAlphaComponent(0.7)

        NSLayoutConstraint.activate([
            safariButton.widthAnchor.constraint(equalToConstant: 40),
            safariButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

        @objc func start(_ sender: Any) {
            defaults.set(keywords1.text!, forKey: "keyword1Req")
            defaults.set(category1.text!, forKey: "category1Req")
            defaults.set(size1.text!, forKey: "size1Req")
            defaults.set(color1.text!, forKey: "color1Req")
            
            if keywords1.text != "" && size1.text != "" && category1.text != "" && color1.text != "" {
                self.performSegue(withIdentifier: "startReq", sender: self)
            }
            
            
        }


        func setupArrays() {
            categories = ["", "Jackets", "Coats", "Shirts", "Tops/Sweaters", "Sweatshirts", "Pants", "Shorts", "T-Shirts", "Hats", "Bags", "Accessories", "Shoes"]
            sizes = ["", "N/A", "Small", "Medium", "Large", "XLarge", "8", "8.5", "9", "9.5", "10", "10.5", "11", "11.5", "12", "12.5", "13", "US 8 / UK 7.5", "US 8.5 / UK 8", "US 9 / UK 8.5", "US 9.5 / UK 9", "US 10 / UK 9.5", "US 10.5 / UK 10", "US 11 / UK 10.5", "US 11.5 / UK 11", "US 12 / UK 11.5", "US 12.5 / UK 12", "US 13 / UK 12.5", "30","32","34","36"]
            
            savedTasks = defaults.stringArray(forKey: "savedReq") ?? [""]
        }
        
        func setupTextFields() {
            category1.delegate = self
            size1.delegate = self
//            locationLbl.delegate = self
        }
        func createPickerView() {
            category1.inputView = pickerView
            size1.inputView = pickerView
//            locationLbl.inputView = pickerView

            pickerView.delegate = self

            
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            toolBar.barTintColor = .systemBackground
            toolBar.tintColor = .systemGray
            
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(Settings.dismissKeyboard))
            
            toolBar.setItems([doneButton], animated: false)
            toolBar.isUserInteractionEnabled = true
            
            category1.inputAccessoryView = toolBar
            size1.inputAccessoryView = toolBar
//            locationLbl.inputAccessoryView = toolBar

        }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        section = indexPath.section
        
        if section == 2 && index == 0 {
            let urlString = "https://docs.google.com/document/d/1AwoCpvFOlBWe2xGxUGHbD6Bpk4cfSJKkftknNW1s9tM/edit?usp=sharing"

            if let url = URL(string: urlString) {
                let vc = SFSafariViewController(url: url)
                vc.delegate = self

                present(vc, animated: true)
            }
        }
    }
}
    extension TaskSettings: UIPickerViewDelegate, UIPickerViewDataSource {
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if category1 == currentTextField {
                return categories.count
            } else if size1 == currentTextField {
                return sizes.count
            }
//            else if locationLbl == currentTextField {
//                return locations.count
//            }
            return 1
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if category1 == currentTextField {
                return categories[row]
            } else if size1 == currentTextField {
                return sizes[row]
            }
//            else if locationLbl == currentTextField {
//                return locations[row]
//            }
            return ""
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if category1 == currentTextField {
                category1.text = categories[row]
            } else if size1 == currentTextField {
                size1.text = sizes[row]
            }
//            else if locationLbl == currentTextField {
//                locationLbl.text = locations[row]
//            }
        }
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            
            var label: UILabel
            
            if let view = view as? UILabel {
                label = view
            } else {
                label = UILabel()
            }
    //        label.textColor = .black
    //        label.font = Fonts.SQMedium20
            label.textAlignment = .center
            if category1 == currentTextField {
                label.text = categories[row]
            } else if size1 == currentTextField {
                label.text = sizes[row]
            }
//            else if locationLbl == currentTextField {
//                label.text = locations[row]
//            }
            return label
        }
    }


