//
//  UserProfileRequestHandler.swift
//  YonduApp
//
//  Created by Darren Lester Erandio on 8/31/23.
//

import Foundation

struct UserProfileRequestHandler {
    
    func profileRequest(for user: User, completionBlock: @escaping (User?, String?) -> ()) {
        
        let params = ["mobile": user.mobile]
        
        RequestHandler().getRequest(to: "user", params: params) { data, error in
            
            guard let data = data, error == nil else {
                completionBlock(nil, error?.localizedDescription)
                return
            }
            
            guard let data = try? JSONDecoder().decode(UserProfileResponse.self, from: data) else {
                completionBlock(nil, AppDefinedErrors.httpRequestFailed.localizedDescription)
                return
            }
            
            completionBlock(data.data?.user?.toUser(), nil)
        }
    }
    
}
