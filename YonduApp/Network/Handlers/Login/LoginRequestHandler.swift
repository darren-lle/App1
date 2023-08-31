//
//  LoginRequestHandler.swift
//  YonduApp
//
//  Created by Darren Lester Erandio on 8/31/23.
//

import Foundation

struct LoginRequestHandler {
    
    func loginRequest(for user: User, completionBlock: @escaping (User?, String?) -> ()) {
        let loginRequest = LoginRequest(user: user)
        
        guard let data = try? JSONEncoder().encode(loginRequest) else {
            completionBlock(nil, AppDefinedErrors.unknownError.localizedDescription)
            return
        }
        
        RequestHandler().postRequest(to: "login", body: data) { data, error in
            
            guard let data = data else {
                completionBlock(nil, error?.localizedDescription)
                return
            }
            
            guard let data = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completionBlock(nil, AppDefinedErrors.httpRequestFailed.localizedDescription)
                return
            }
            
            completionBlock(data.data?.user?.toUser(), data.message)
        }
    }
    
}
