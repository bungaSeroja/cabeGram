//
//  LoginViewController.swift
//  cabeGram
//
//  Created by Harrie Santoso on 25/09/19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginHandler: LoginHandler = LoginHandler()
    
    var userNameTextField: UITextField = UITextField()
    var passwordTextField: UITextField = UITextField()
    var submitButton: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        let user: String? = UserDefaults.standard.string(forKey: UserKey.User.rawValue)
        
        if user != nil {
            moveToHome()
        }
        
        loginHandler.guider = self
        snitch()
    }
    
    private func snitch() {
        snitchUserNameField()
        snitchPasswordField()
        snitchSubmitButton()
    }
    
    private func snitchUserNameField() {
        
        view.backgroundColor = .gray
        
        let sideMargin: CGFloat = 20
        let textFieldWidth: CGFloat = view.frame.size.width - (2 * sideMargin)
        let frame: CGRect = CGRect(x: sideMargin,
                                   y: view.frame.height * 1/3,
                                   width: textFieldWidth,
                                   height: 44)
        
        userNameTextField.frame = frame
        userNameTextField.placeholder = "Masukan userName anda!"
        userNameTextField.borderStyle = .roundedRect
        userNameTextField.addTarget(loginHandler,
                                    action: #selector(LoginHandler.updateUserNameCache(_:)),
                                    for: .editingChanged)
        
        view.addSubview(userNameTextField)
    }
    
    private func snitchPasswordField() {
        
        let topMargin: CGFloat = 8
        
        passwordTextField.frame = userNameTextField.frame.offsetBy(dx: 0,
                                                                   dy: userNameTextField.frame.height + topMargin)
        passwordTextField.placeholder = "Masukan Password anda!"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addTarget(loginHandler,
                                    action: #selector(LoginHandler.updatePasswordCache(_:)),
                                    for: .editingChanged)
        
        view.addSubview(passwordTextField)
    }
    
    private func snitchSubmitButton() {
        
        let topMargin: CGFloat = 16
        
        submitButton.frame = passwordTextField.frame.offsetBy(dx: 0,
                                                              dy: passwordTextField.frame.height + topMargin)
        
        submitButton.backgroundColor = .darkGray
        submitButton.setTitle("Login", for: .normal)
        submitButton.addTarget(loginHandler,
                               action: #selector(LoginHandler.onTap),
                               for: .touchDown)
        
        view.addSubview(submitButton)
    }
}

extension LoginViewController: LoginHandlerGuider {
    func moveToHome() {
        
        let tabHomeItem: UITabBarItem = UITabBarItem(title: "Home",
                                                     image: nil,
                                                     selectedImage: nil)
        let tabProfileItem: UITabBarItem = UITabBarItem(title: "Profile",
                                                        image: nil,
                                                        selectedImage: nil)
        
        let homeVC: HomeViewController = HomeViewController()
        homeVC.tabBarItem = tabHomeItem
        
        let profileVC: ProfileViewController = ProfileViewController()
        profileVC.tabBarItem = tabProfileItem
        
        let tabVC: UITabBarController = UITabBarController()
        tabVC.viewControllers = [homeVC, profileVC]
        
        let navVC: UINavigationController = UINavigationController()
        navVC.viewControllers = [tabVC]
        
        self.present(navVC,
                     animated: true,
                     completion: nil)
    }
}

class LoginHandler {
    
    var userNameCache: String = ""
    var passwordCache: String = ""
    var guider: LoginHandlerGuider?
    
    @objc func onTap() {
        saveUserData()
        guider?.moveToHome()
    }
    
    @objc func updateUserNameCache(_ textField: UITextField) {
        userNameCache = textField.text ?? ""
    }
    
    @objc func updatePasswordCache(_ textField: UITextField) {
        passwordCache = textField.text ?? ""
    }
    
    private func saveUserData() {
        UserDefaults.standard.set(userNameCache, forKey: UserKey.User.rawValue)
        UserDefaults.standard.set(passwordCache, forKey: UserKey.Password.rawValue)
    }
}

enum UserKey: String {
    case User
    case Password
}

protocol LoginHandlerGuider {
    func moveToHome()
}
