//
//  ViewController.swift
//  Mesa News
//
//  Created by Diana Monteiro on 11/11/20.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginEmail: UITextField! // TODO: loginEmail só aceitar emails validos
    @IBOutlet weak var loginPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginEmail.delegate = self
        loginPassword.delegate = self
    }

    @IBAction func nativeLogin(_ sender: UIButton) {
        loginPassword.endEditing(true)
        
        print(loginEmail.text!)
        print(loginPassword.text!)
    }
    
    @IBAction func facebookLogin(_ sender: UIButton) {
        // TODO: Ver API do Facebook
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginPassword.endEditing(true)
        print(loginEmail.text!)
        print(loginPassword.text!)
        return true
    }
}

