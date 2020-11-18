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
    @IBOutlet weak var subscribeButton: UIButton!
    
    var presenter = SignUpPresenter()
    var ySelectedTextField: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        nameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
        birthDateField.delegate = self
        
        // Listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        presenter.delegate = self
    }
    
    deinit {
        // Stop listening for keyboard events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @IBAction func subscribeUser(_ sender: UIButton) {
        trySigningUp()
    }
    
    func trySigningUp() {
        birthDateField.endEditing(true)
        if passwordField.text != confirmPasswordField.text {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Falha ao cadastrar", message: "As senhas devem ser iguais", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Entendi", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
        } else {
            presenter.getSignedUp(name: nameField.text!, email: emailField.text!, password: passwordField.text!, birthDate: birthDateField.text!)
        }
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let yTextField = textField.convert(textField.frame.origin, to: self.view).y
        let heightTextField = textField.frame.height
        ySelectedTextField = yTextField + heightTextField
    }
    
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == birthDateField {
            
            if (birthDateField.text?.count == 2) || (birthDateField.text?.count == 5) {
                if !(string == "") {
                    birthDateField?.text = (birthDateField?.text)! + "/"
                }
            }
            // check the condition not exceed 9 chars
            return !(textField.text!.count > 9 && (string.count) > range.length)
        }
        else {
            return true
        }
    }
    
    @objc func keyboardWillChange(notification: Notification) {
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let yKeyboard = self.view.frame.height - keyboardRect.height
        
        if (notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification) && ySelectedTextField >= yKeyboard {
            view.frame.origin.y = -keyboardRect.height + subscribeButton.frame.height
        } else {
            view.frame.origin.y = 0
        }
        
    }
    
}
