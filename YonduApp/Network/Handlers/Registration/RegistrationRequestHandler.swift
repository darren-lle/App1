//
//  RegistrationRequestHandler.swift
//  YonduApp
//
//  Created by Darren Lester Erandio on 8/31/23.
//

import Foundation

struct RegistrationRequestHandler {
    
    func registerRequest(for user: User, completionBlock: @escaping (Bool, String?) -> ()) {
        let userData = UserData(user: user)
        
        guard let data = try? JSONEncoder().encode(userData) else {
            completionBlock(false, AppDefinedErrors.unknownError.localizedDescription)
            return
        }
        
        RequestHandler().postRequest(to: "register", body: data) { data, error in
            
            guard let data = data else {
                completionBlock(false, error?.localizedDescription)
                return
            }
            
            guard let data = try? JSONDecoder().decode(RegistrationResponse.self, from: data) else {
                completionBlock(false, AppDefinedErrors.httpRequestFailed.localizedDescription)
                return
            }
            
            completionBlock(true, data.message)
        }
    }
    
}
