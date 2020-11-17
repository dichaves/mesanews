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
    @IBOutlet weak var errorMessageLabel: UILabel!
    
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
            
            // Print out access token
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
            self.errorMessageLabel.text = errorMessage
            self.errorMessageLabel.isHidden = false
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
