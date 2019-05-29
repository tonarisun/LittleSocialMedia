//
//  LoginFormController.swift
//  Weather
//
//  Created by Olga Lidman on 27/02/2019.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginFormController: UIViewController {
    
    private let singInSegID = "enterSegue"
    @IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var LoginTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    var listener: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        loginScrollView.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        listener = Auth.auth().addStateDidChangeListener { _, user in
            if user != nil {
                self.performSegue(withIdentifier: "enterSegue", sender: self)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        if listener != nil {
            Auth.auth().removeStateDidChangeListener(listener!)
        } else {
            return
        }
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
    
    @IBAction func logIn(_ sender: Any) {
        if let email = LoginTextField.text,
            let password = PasswordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
                guard self != nil else { return }
                if user != nil {
                    print("---------- совершен вход ----------")
                } else {
                    let alert = UIAlertController(title: "Что-то пошло не так", message: "Проверьте email и пароль", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self!.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func signUp(_ sender: Any) {
        guard let email = LoginTextField.text,
            let password = PasswordTextField.text else { return }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if authResult != nil {
                print("---------- юзер создан, вход совершен ----------")
                Auth.auth().signIn(withEmail: email, password: password, completion: nil)
            } else {
                let alert = UIAlertController(title: "Ошибка регистрации", message: "\(String(describing: error))", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
//  Вход по нажатию на кнопку 'log in'
//
//    @IBAction func SingInButton(_ sender: Any) {
//        if let loginText = LoginTextField.text,
//            let passwordText = PasswordTextField.text {
//            if loginText == "a" && passwordText == "1" {
//                performSegue(withIdentifier: singInSegID, sender: self)
//            } else {
//                let alert = UIAlertController(title: "Что-то не так", message: "Неверное имя пользователи или пароль", preferredStyle: .alert)
//                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//                alert.addAction(action)
//                present(alert, animated: true, completion: nil)
//            }
//        }
//    }

