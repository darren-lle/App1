//
//  RequestHandler.swift
//  YonduApp
//
//  Created by Darren Lester Erandio on 8/31/23.
//

import Foundation

struct RequestHandler {
    private var urlSession = URLSession.shared
    private let hostUrl = "http://localhost:3001/"
    
    func postRequest(to endpoint: String, body: Data? = nil, completionBlock: @escaping (Data?, Error?) -> ()) {
        
        guard let finalUrl = URL(string: hostUrl + endpoint) else {
            completionBlock(nil, AppDefinedErrors.unknownError)
            return
        }
        
        var request = URLRequest(url: finalUrl)
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")

        request.httpMethod = RequestTypes.post.rawValue
        if let body = body {
            request.httpBody = body
        }
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            completionBlock(data, error)
        }
        
        task.resume()
    }
    
    func getRequest(to endpoint: String, params: [String: String], completionBlock: @escaping (Data?, Error?) -> ()) {
        
        var components = URLComponents(string: hostUrl + endpoint)
        components?.queryItems = []
        
        params.forEach { key, value in
            components?.queryItems?.append(URLQueryItem(name: key, value: value))
        }
        
        guard let finalUrl = components?.url else {
            completionBlock(nil, AppDefinedErrors.unknownError)
            return
        }
        
        var request = URLRequest(url: finalUrl)
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")

        request.httpMethod = RequestTypes.get.rawValue
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            completionBlock(data, error)
        }
        
        task.resume()
    }
}
