//
//  AppSearchViewModel.swift
//  AlreadyExists?
//
//  Created by richard Haynes on 4/19/26.
//

import Foundation
import SwiftUI
import Combine

/// ViewModel for app name/description search
@MainActor
final class AppSearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchResults: [AppResult] = []
    @Published var isLoading: Bool = false
    @Published var errorState: AppError?
    @Published var searchMode: SearchMode = .name
    
    private let service: AppStoreSearching
    
    enum SearchMode: String, CaseIterable {
        case name = "App Name"
        case description = "Description"
    }
    
    init(service: AppStoreSearching = AppStoreService()) {
        self.service = service
    }
    
    /// Computed property to determine if exact name match exists
    var exactNameMatch: AppResult? {
        guard searchMode == .name else { return nil }
        return searchResults.first { $0.trackName.lowercased() == searchText.lowercased() }
    }
    
    /// User-friendly search result message
    var resultMessage: String {
        if isLoading {
            return "Searching..."
        }
        
        if let error = errorState {
            return error.localizedDescription
        }
        
        if searchText.isEmpty {
            return ""
        }
        
        switch searchMode {
        case .name:
            if let match = exactNameMatch {
                return "✗ Name taken by '\(match.trackName)' from \(match.artistName ?? "Unknown Developer")"
            } else if !searchResults.isEmpty {
                return "✓ Exact name available, but found \(searchResults.count) similar name(s)"
            } else {
                return "✓ Name appears to be available"
            }
        case .description:
            if searchResults.isEmpty {
                return "No similar apps found"
            } else {
                return "Found \(searchResults.count) app(s) with similar description"
            }
        }
    }
    
    /// Perform search based on current mode
    func performSearch() async {
        let trimmedText = searchText.trimmingCharacters(in: .whitespaces)
        
        guard !trimmedText.isEmpty else {
            searchResults = []
            errorState = nil
            return
        }
        
        isLoading = true
        errorState = nil
        searchResults = []
        
        do {
            let response: AppStoreSearchResponse
            
            switch searchMode {
            case .name:
                response = try await service.searchByName(trimmedText)
            case .description:
                response = try await service.searchByDescription(trimmedText)
            }
            
            searchResults = response.results
        } catch let error as AppError {
            errorState = error
        } catch {
            errorState = .unknown
        }
        
        isLoading = false
    }
    
    /// Clear all search state
    func clearSearch() {
        searchText = ""
        searchResults = []
        errorState = nil
    }
}
