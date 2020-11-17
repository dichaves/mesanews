//
//  ViewController.swift
//  Mesa News
//
//  Created by Diana Monteiro on 11/11/20.
//

import UIKit
import FBSDKLoginKit

class SignInViewController: UIViewController, SignInDelegate {
    
    @IBOutlet weak var loginEmail: UITextField!
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var signInView: UIStackView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    var presenter = SignInPresenter()
    
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
        loginPassword.endEditing(true)
        trySigningIn()
    }
    
    func trySigningIn() {
        // to do last: checar se os required fields foram preenchidos
        presenter.getSignedIn(email: loginEmail.text!, password: loginPassword.text!)
        // esperar resposta: se autorizar, segue to feed; se não, mostra qual foi o erro
    }
    
    func returnError(message: String) {
        DispatchQueue.main.async {
            self.errorMessageLabel.text = message
            self.errorMessageLabel.isHidden = false
        }
    }
}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginEmail {
            loginPassword.becomeFirstResponder()
        } else if textField == loginPassword {
            loginPassword.endEditing(true)
            trySigningIn()
        }
        return true
    }
    
}

