//
//  RewardsListRequestHandler.swift
//  YonduApp
//
//  Created by Darren Lester Erandio on 8/31/23.
//

import Foundation

struct RewardsListRequestHandler {
    func requestRewards(completionBlock: @escaping ([Rewards]?, String?) -> ()) {
        RequestHandler().getRequest(to: "rewards", params: [:]) { data, error in
            
            guard let data = data, error == nil else {
                completionBlock(nil, error?.localizedDescription)
                return
            }
            
            guard let data = try? JSONDecoder().decode(RewardsListResponse.self, from: data) else {
                completionBlock(nil, AppDefinedErrors.httpRequestFailed.localizedDescription)
                return
            }
            
            completionBlock(data.toRewardsList(), nil)
        }
    }
}
