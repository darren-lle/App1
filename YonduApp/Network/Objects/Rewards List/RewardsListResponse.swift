//
//  RewardsResponse.swift
//  YonduApp
//
//  Created by Darren Lester Erandio on 8/31/23.
//

import Foundation

struct RewardsListResponse: Codable {
    let status: Int
    let message: String
    let data: DataListClass?
}

extension RewardsListResponse {
    func toRewardsList() -> [Rewards] {
        var list: [Rewards] = []
        
        for rewards in data?.list ?? []{
            list.append(Rewards(id: rewards.id,
                                name: rewards.name,
                                description: rewards.description,
                                image: rewards.image))
        }
        
        return list
    }
}
