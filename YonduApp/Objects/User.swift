//
//  User.swift
//  YonduApp
//
//  Created by Darren Lester Erandio on 8/31/23.
//

import Foundation

class User {
    let id: String?
    let firstName, lastName, mobile: String
    let mpin: String?
    let isVerified: Bool?
    let referralCode: String?
    
    init(id: String? = nil, firstName: String, lastName: String, mobile: String, mpin: String? = nil,
         isVerified: Bool? = nil, referralCode: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.mobile = mobile
        self.mpin = mpin
        self.isVerified = isVerified
        self.referralCode = referralCode
    }
}
