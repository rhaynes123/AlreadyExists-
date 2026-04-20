//
//  AppStoreSearchResult.swift
//  AlreadyExists?
//
//  Created by richard Haynes on 4/19/26.
//

import Foundation

/// Response from the iTunes Search API
struct AppStoreSearchResponse: Codable, Sendable {
    let resultCount: Int
    let results: [AppResult]
}

/// Individual app result from the iTunes Search API
struct AppResult: Codable, Sendable, Identifiable {
    let trackId: Int
    let trackName: String
    let artistName: String?
    let description: String?
    let artworkUrl100: String?
    let averageUserRating: Double?
    let userRatingCount: Int?
    let primaryGenreName: String?
    
    var id: Int { trackId }
}
