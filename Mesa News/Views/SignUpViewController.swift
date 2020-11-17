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
    }
    
    @IBAction func subscribeUser(_ sender: UIButton) {
        trySigningUp()
    }
    
    func trySigningUp() {
        // to do last: checar se os required fields foram preenchidos
        // check is passwords match
        presenter.getSignedUp(name: nameField.text!, email: emailField.text!, password: passwordField.text!)
        // esperar resposta: se autorizar, segue to feed; se não, mostra qual foi o erro
    }

}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let textFields = [nameField, emailField, passwordField, confirmPasswordField, birthDateField]
        let fieldIndex = textFields.firstIndex(of: textField)!
        if fieldIndex < textFields.count - 1 {
            textFields[fieldIndex + 1]!.becomeFirstResponder()
        } else {
            textField.endEditing(true)
            trySigningUp()
        }
        return true
    }
    
}
