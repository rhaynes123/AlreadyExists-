//
//  AppError.swift
//  AlreadyExists?
//
//  Created by richard Haynes on 4/19/26.
//

import Foundation

/// Application-level errors with user-friendly messages
enum AppError: LocalizedError, Equatable {
    case networkUnavailable
    case invalidResponse
    case searchFailed(String)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .networkUnavailable:
            return "Unable to connect to the App Store. Please check your internet connection."
        case .invalidResponse:
            return "Received an unexpected response from the App Store."
        case .searchFailed(let reason):
            return "Search failed: \(reason)"
        case .unknown:
            return "An unexpected error occurred. Please try again."
        }
    }
}
