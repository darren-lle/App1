//
//  RegisterViewController.swift
//  YonduExam
//
//  Created by Darren Lester Erandio on 8/30/23.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        performSegue(withIdentifier: "registerToMain", sender: self)
    }
}

