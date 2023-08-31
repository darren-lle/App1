//
//  LoginViewController.swift
//  YonduExam
//
//  Created by Darren Lester Erandio on 8/30/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var mobileErrorLabel: UILabel!
    @IBOutlet weak var mpinTextField: UITextField!
    @IBOutlet weak var mpinErrorLabel: UILabel!
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var progressIndicatorView: UIActivityIndicatorView!
    
    private var registeredUser: User!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareSecureTextFields()
        loading(false)
    }


}

extension LoginViewController {
    func prepareSecureTextFields() {
        mpinTextField.enablePasswordToggle()
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
        
        mobileErrorLabel.isHidden = true
        mpinErrorLabel.isHidden = true
        
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
            
            return
        }
        
        validateMobile()
        validateMpin()
        
        return valid
    }
    
    func loginUser() {
        
        guard validateInputs() else {
            return
        }
        loading(true)
        
        let loginUser = User(firstName: "",
                        lastName: "",
                        mobile: mobileTextField.text!,
                        mpin: mpinTextField.text!)
        
        DispatchQueue.global(qos: .background).async {
            LoginRequestHandler().loginRequest(for: loginUser) { [weak self] user, message in
                DispatchQueue.main.async {
                    self?.loading(false)
                    
                    if let user = user {
                        self?.registeredUser = user
                        self?.performSegue(withIdentifier: "loginToMain", sender: self)
                        return
                    }
                    
                    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .destructive))
                    
                    self?.present(alert, animated: true)
                }
            }
        }
    }
}

extension LoginViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToMain" {
            guard let navigationController = segue.destination as? UINavigationController,
                  let vc = navigationController.topViewController as? MainViewController,
                    let user = registeredUser else {
                return
            }
            
            vc.set(user)
        }
    }
}

extension LoginViewController {
    @IBAction func didTapLogin(_ sender: UIButton) {
        loginUser()
    }
}
