//
//  String+ClassDescription.swift
//  YonduExam
//
//  Created by Darren Lester Erandio on 8/30/23.
//

import UIKit

extension UIView {
    static func className() -> String {
        String(describing: self)
    }
}
