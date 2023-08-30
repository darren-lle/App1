//
//  LoginViewController.swift
//  YonduExam
//
//  Created by Darren Lester Erandio on 8/30/23.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension LoginViewController {
    @IBAction func didTapLogin(_ sender: UIButton) {
        performSegue(withIdentifier: "logintToMain", sender: self)
    }
}
