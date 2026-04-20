//
//  AppStoreService.swift
//  AlreadyExists?
//
//  Created by richard Haynes on 4/19/26.
//

import Foundation

/// Protocol for App Store search operations
protocol AppStoreSearching: Sendable {
    func searchByName(_ name: String) async throws -> AppStoreSearchResponse
    func searchByDescription(_ description: String) async throws -> AppStoreSearchResponse
}

/// Service for searching the App Store using iTunes Search API
final class AppStoreService: AppStoreSearching {
    private let session: URLSession
    private let baseURL = "https://itunes.apple.com/search"
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    /// Search for apps by exact name match
    func searchByName(_ name: String) async throws -> AppStoreSearchResponse {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw AppError.searchFailed("App name cannot be empty")
        }
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "term", value: name),
            URLQueryItem(name: "entity", value: "software"),
            URLQueryItem(name: "country", value: "us"),
            URLQueryItem(name: "limit", value: "25")
        ]
        
        guard let url = components?.url else {
            throw AppError.invalidResponse
        }
        
        return try await performSearch(url: url)
    }
    
    /// Search for apps by description keywords
    func searchByDescription(_ description: String) async throws -> AppStoreSearchResponse {
        guard !description.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw AppError.searchFailed("Description cannot be empty")
        }
        
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "term", value: description),
            URLQueryItem(name: "entity", value: "software"),
            URLQueryItem(name: "country", value: "us"),
            URLQueryItem(name: "limit", value: "25")
        ]
        
        guard let url = components?.url else {
            throw AppError.invalidResponse
        }
        
        return try await performSearch(url: url)
    }
    
    // MARK: - Private Helpers
    
    private func performSearch(url: URL) async throws -> AppStoreSearchResponse {
        #if DEBUG
        print("🔍 Searching App Store: \(url.absoluteString)")
        #endif
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw AppError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw mapHTTPError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            let searchResponse = try decoder.decode(AppStoreSearchResponse.self, from: data)
            
            #if DEBUG
            print("✅ Found \(searchResponse.resultCount) results")
            #endif
            
            return searchResponse
        } catch {
            #if DEBUG
            print("❌ Decoding error: \(error)")
            #endif
            throw AppError.invalidResponse
        }
    }
    
    private func mapHTTPError(statusCode: Int) -> AppError {
        switch statusCode {
        case 400...499:
            return .searchFailed("Invalid search request")
        case 500...599:
            return .searchFailed("App Store service unavailable")
        default:
            return .unknown
        }
    }
}
