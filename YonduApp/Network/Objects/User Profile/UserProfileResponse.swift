//
//  UserProfileResponse.swift
//  YonduApp
//
//  Created by Darren Lester Erandio on 8/31/23.
//

import Foundation

struct UserProfileResponse: Codable {
    let status: Int
    let message: String
    let data: DataUserClass?
}
