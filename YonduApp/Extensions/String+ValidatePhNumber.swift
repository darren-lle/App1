//
//  String.swift
//  YonduApp
//
//  Created by Darren Lester Erandio on 8/31/23.
//

import Foundation

extension String {
    func isValidPhNumber() -> Bool {
        let range = NSRange(location: 0, length: self.utf16.count)
        let regex = try! NSRegularExpression(pattern: "^(09(\\d){9,9})$")
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }
}
