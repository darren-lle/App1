//
//  Error.swift
//  YonduApp
//
//  Created by Darren Lester Erandio on 8/31/23.
//

import Foundation

public enum AppDefinedErrors: Error {
    case unknownError, httpRequestFailed
}

extension AppDefinedErrors: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknownError:
            return "Unknown Error"
        case .httpRequestFailed:
            return "HTTP Request Failed"
        }
    }
}
