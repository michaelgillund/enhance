//
//  AddTask.swift
//  Enhance
//
//  Created by Michael Gillund on 8/24/20.
//  Copyright © 2020 Michael Gillund. All rights reserved.
//

import UIKit

class AddTask: UIViewController {
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var keywordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var keywordText: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var categoryText: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var sizeText: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var colorText: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
