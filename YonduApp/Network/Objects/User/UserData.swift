//
//  User.swift
//  YonduApp
//
//  Created by Darren Lester Erandio on 8/31/23.
//

import Foundation

struct UserData: Codable {
    let id, referralCode, mpin: String?
    let firstName, lastName, mobile: String
    let isVerified: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case mobile
        case mpin
        case isVerified = "is_verified"
        case referralCode = "referral_code"
    }
}

extension UserData {
    init(user: User) {
        firstName = user.firstName
        lastName = user.lastName
        mobile = user.mobile
        mpin = user.mpin
        
        id = nil
        isVerified = nil
        referralCode = nil
    }
    
    func toUser() -> User {
        return User(id: id,
                    firstName: firstName,
                    lastName: lastName,
                    mobile: mobile,
                    mpin: mpin,
                    isVerified: isVerified,
                    referralCode: referralCode)
    }
}
