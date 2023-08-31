//
//  Registration.swift
//  YonduApp
//
//  Created by Darren Lester Erandio on 8/31/23.
//

import Foundation

struct RegistrationRequest: Codable {
    let firstName, lastName, mobile, mpin: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case mobile, mpin
    }
}
