//
//  DataClass.swift
//  YonduApp
//
//  Created by Darren Lester Erandio on 8/31/23.
//

import Foundation

struct DataUserClass: Codable {
    let user: UserData?
}

struct DataListClass: Codable {
    let list: [RewardsData]?
}
