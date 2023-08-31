//
//  Reward.swift
//  YonduApp
//
//  Created by Darren Lester Erandio on 8/31/23.
//

import Foundation

class Rewards {
    let id: String?
    let name, description, image: String
    
    init(id: String? = nil, name: String, description: String, image: String) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
    }
}
