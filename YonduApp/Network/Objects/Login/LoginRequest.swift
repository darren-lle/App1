//
//  LoginRequest.swift
//  YonduApp
//
//  Created by Darren Lester Erandio on 8/31/23.
//

import Foundation

struct LoginRequest: Codable {
    let mobile, mpin: String
}

extension LoginRequest {
    init(user: User){
        mobile = user.mobile
        mpin = user.mpin
    }
}
