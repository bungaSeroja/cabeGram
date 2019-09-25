//
//  ProfileViewController.swift
//  cabeGram
//
//  Created by Harrie Santoso on 26/09/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    private var ngantukLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ngantukLabel.frame = view.frame
        ngantukLabel.text = "maaf udah ga kuat, ngantuk"
        view.backgroundColor = .lightGray
        view.addSubview(ngantukLabel)
    }
}
