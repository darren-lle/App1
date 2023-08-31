//
//  UITextField+SecureToggle.swift
//  YonduApp
//
//  Created by Darren Lester Erandio on 8/31/23.
//

import UIKit

extension UITextField {
    
    func enablePasswordToggle(){
        
        let button = UIButton(type: .custom)
        
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.setImage(UIImage(systemName: "eye"), for: .selected)
        button.tintColor = .gray
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = button
        rightViewMode = .always
        button.alpha = 0.5
    }
    
    @objc func togglePasswordView(_ sender: UIButton) {
        isSecureTextEntry.toggle()
        sender.isSelected.toggle()
    }
}
