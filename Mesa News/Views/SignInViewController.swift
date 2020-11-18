//
//  ViewController.swift
//  Mesa News
//
//  Created by Diana Monteiro on 11/11/20.
//

import UIKit
import FBSDKLoginKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var signInView: UIStackView!
    
    var presenter = SignInPresenter()
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        loginEmail.delegate = self
        loginPassword.delegate = self
        presenter.delegate = self
        
        addFBLoginButton()
    }
    
    func addFBLoginButton() {
        let loginButton = FBLoginButton()
        signInView.addArrangedSubview(loginButton)
        // signInView.insertArrangedSubview(loginButton, at: 3)
        
        // COLOCAR NO PRESENTER:
        // This will trigger after successfully login / logout
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
        
            print("FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
        }
    }

    @IBAction func nativeLogin(_ sender: UIButton) {
        trySigningIn()
    }
    
    func trySigningIn() {
        loginPassword.endEditing(true)
        presenter.getSignedIn(email: loginEmail.text!, password: loginPassword.text!)
    }
}

extension SignInViewController: SignInUpDelegate {

    func userDidNotAuth(errorMessage: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Falha ao fazer login", message: "E-mail e/ou senha incorretos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Entendi", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginEmail {
            loginPassword.becomeFirstResponder()
        } else if textField == loginPassword {
            trySigningIn()
        }
        return true
    }
    
}
