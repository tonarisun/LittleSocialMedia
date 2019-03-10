//
//  LoginFormController.swift
//  Weather
//
//  Created by Olga Lidman on 27/02/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit

class LoginFormController: UIViewController {

    private let singInSegID = "singInSegue"
    @IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var LoginTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Diamond-Peak-Sunset-By-Robert-Bynum-iPad-Pro-Wallpaper-2732x2732")!)
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        loginScrollView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillBeHidden),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardHeight = keyboardFrameValue.cgRectValue.height
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardHeight, right: 0.0)
        
        loginScrollView?.contentInset = contentInsets
        loginScrollView?.scrollIndicatorInsets = contentInsets
    }
    
    @objc func hideKeyboard() {
        self.loginScrollView?.endEditing(true)
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        loginScrollView?.contentInset = contentInsets
        loginScrollView?.scrollIndicatorInsets = contentInsets
    }

    @IBAction func SingInButton(_ sender: Any) {
        if let loginText = LoginTextField.text,
           let passwordText = PasswordTextField.text {
            if loginText == "a" && passwordText == "1" {
                performSegue(withIdentifier: singInSegID, sender: self)
            } else {
                let alert = UIAlertController(title: "Ошибка", message: "Введены неверные данные пользователя", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
}
