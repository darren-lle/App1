//
//  RegisterViewController.swift
//  YonduExam
//
//  Created by Darren Lester Erandio on 8/30/23.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var progressIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var firstNameErrorLabel: UILabel!
    @IBOutlet weak var lastNameErrorLabel: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var mobileErrorLabel: UILabel!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var mpinErrorLabel: UILabel!
    @IBOutlet weak var mpinTextField: UITextField!
    @IBOutlet weak var confirmMpinTextField: UITextField!
    @IBOutlet weak var confirmMpinerrorLabel: UILabel!
    
    private var registeredUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loading(false)
        prepareSecureTextFields()
    }
    

}

private extension RegisterViewController {
    
    func prepareSecureTextFields() {
        mpinTextField.enablePasswordToggle()
        confirmMpinTextField.enablePasswordToggle()
    }
    
    func loading(_ loading: Bool) {
        UIView.animate(withDuration: 0.5) {[weak self] in
            self?.view.isUserInteractionEnabled = !loading
            self?.loadingView.isHidden = !loading
            loading ? self?.progressIndicatorView.startAnimating() : self?.progressIndicatorView.stopAnimating()
        }
    }
    
    func validateInputs() -> Bool {
        
        var valid = true
        
        firstNameErrorLabel.isHidden = true
        lastNameErrorLabel.isHidden = true
        mobileErrorLabel.isHidden = true
        mpinErrorLabel.isHidden = true
        confirmMpinerrorLabel.isHidden = true
        
        func validate(_ textField: UITextField, errorLabel: UILabel) -> Bool {
            let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            
            if text.isEmpty {
                errorLabel.isHidden = false
                valid = false
                return false
            }
            
            return true
        }
        
        func validateMobile() {
            guard validate(mobileTextField, errorLabel: mobileErrorLabel) else {
                mobileErrorLabel.text = "Mobile is required"
                return
            }
            
            let number = mobileTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            
            guard number.isValidPhNumber() else {
                mobileErrorLabel.text = "Mobile format should be 09xxxxxxxx"
                mobileErrorLabel.isHidden = false
                valid = false
                return
            }
            
            return
        }
        
        func validateMpin() {
            guard validate(mpinTextField, errorLabel: mpinErrorLabel) else {
                mobileErrorLabel.text = "Mpin is required"
                return
            }
            
            let mpin = mpinTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            
            guard let _ = Int(mpin), mpin.count == 4 else {
                mpinErrorLabel.text = "Mpin should only consists of numbers and should be 4 digits"
                mpinErrorLabel.isHidden = false
                valid = false
                return
            }
            
            guard validate(confirmMpinTextField, errorLabel: confirmMpinerrorLabel) else { return }
            
            let confirmMpin = confirmMpinTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
            
            guard mpin == confirmMpin else {
                confirmMpinerrorLabel.isHidden = false
                valid = false
                return
            }
            
            return
        }
        
        _ = validate(firstNameTextField, errorLabel: firstNameErrorLabel)
        _ = validate(lastNameTextField, errorLabel: lastNameErrorLabel)
        
        validateMobile()
        validateMpin()
        
        return valid
    }
    
    func registerUser() {
        
        guard validateInputs() else {
            return
        }
        loading(true)
        
        let user = User(firstName: firstNameTextField.text!,
                        lastName: lastNameTextField.text!,
                        mobile: mobileTextField.text!,
                        mpin: mpinTextField.text!)
        
        DispatchQueue.global(qos: .background).async {
            RegistrationRequestHandler().registerRequest(for: user) { [weak self] success, message in
                DispatchQueue.main.async {
                    var title: String
                    var action: UIAlertAction!
                    
                    if success {
                        self?.registeredUser = user
                        title = "Success"
                        action = UIAlertAction(title: "Proceed", style: .default) { _ in
                            self?.performSegue(withIdentifier: "registerToMain", sender: self)
                        }
                    } else {
                        title = "Error"
                        action = UIAlertAction(title: "Ok", style: .destructive)
                    }
                    
                    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    alert.addAction(action)
                    
                    self?.present(alert, animated: true)
                    self?.loading(false)
                }
            }
        }
    }
}

extension RegisterViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "registerToMain" {
            guard let navigationController = segue.destination as? UINavigationController,
                  let vc = navigationController.topViewController as? MainViewController,
                    let user = registeredUser else {
                return
            }
            
            vc.set(user)
        }
    }
}

extension RegisterViewController {
    @IBAction func didTapBackButton(_ sender: UIButton) {
        
        let confirmAlert = UIAlertController(title: "Confirmation", message: "Are you sure you want to cancel your registration?", preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "Yes", style: .default) { [weak self] action in
            
            guard let self = self else { return }
            
            self.performSegue(withIdentifier: "unwindRegisterVC", sender: self)
            
        }
        
        let cancel = UIAlertAction(title: "No", style: .cancel)
        
        confirmAlert.addAction(confirm)
        confirmAlert.addAction(cancel)
        
        self.present(confirmAlert, animated: true)
        
    }
    
    @IBAction func didTapRegister(_ sender: UIButton) {
        registerUser()
    }
    
    @objc func toggleTextfield(textfield: UITextField) {
        textfield.isSecureTextEntry.toggle()
    }
}

