//
//  SignUpViewController.swift
//  Mesa News
//
//  Created by Diana Monteiro on 13/11/20.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var birthDateField: UITextField!
    
    var presenter = SignUpPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
        birthDateField.delegate = self
        
        presenter.delegate = self
    }
    
    @IBAction func subscribeUser(_ sender: UIButton) {
        trySigningUp()
    }
    
    func trySigningUp() {
        birthDateField.endEditing(true)
        presenter.getSignedUp(name: nameField.text!, email: emailField.text!, password: passwordField.text!)
    }

}

extension SignUpViewController: SignInUpDelegate {

    func userDidNotAuth(errorMessage: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Falha ao cadastrar", message: errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Entendi", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textFields = [nameField, emailField, passwordField, confirmPasswordField, birthDateField]
        let fieldIndex = textFields.firstIndex(of: textField)!
        if fieldIndex < textFields.count - 1 {
            textFields[fieldIndex + 1]!.becomeFirstResponder()
        } else {
            trySigningUp()
        }
        return true
    }
    
}
