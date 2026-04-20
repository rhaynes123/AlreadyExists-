//
//  AlreadyExists_Tests.swift
//  AlreadyExists?Tests
//
//  Created by richard Haynes on 4/18/26.
//

import Testing
import Foundation
@testable import AlreadyExists_

// MARK: - Mock Service

final class MockAppStoreService: AppStoreSearching {
    var searchByNameResult: Result<AppStoreSearchResponse, Error>?
    var searchByDescriptionResult: Result<AppStoreSearchResponse, Error>?
    
    func searchByName(_ name: String) async throws -> AppStoreSearchResponse {
        guard let result = searchByNameResult else {
            throw AppError.unknown
        }
        return try result.get()
    }
    
    func searchByDescription(_ description: String) async throws -> AppStoreSearchResponse {
        guard let result = searchByDescriptionResult else {
            throw AppError.unknown
        }
        return try result.get()
    }
}

// MARK: - ViewModel Tests

@Suite("AppSearchViewModel Tests")
@MainActor
struct AppSearchViewModelTests {
    
    // MARK: - Success State Tests
    
    @Test("Search by name returns exact match")
    func searchByNameExactMatch() async throws {
        // Arrange
        let mockService = MockAppStoreService()
        let mockApp = AppResult(
            trackId: 1,
            trackName: "TestApp",
            artistName: "Test Developer",
            description: "A test app",
            artworkUrl100: nil,
            averageUserRating: 4.5,
            userRatingCount: 100,
            primaryGenreName: "Productivity"
        )
        let mockResponse = AppStoreSearchResponse(resultCount: 1, results: [mockApp])
        mockService.searchByNameResult = .success(mockResponse)
        
        let viewModel = AppSearchViewModel(service: mockService)
        viewModel.searchText = "TestApp"
        viewModel.searchMode = .name
        
        // Act
        await viewModel.performSearch()
        
        // Assert
        #expect(viewModel.searchResults.count == 1)
        #expect(viewModel.exactNameMatch?.trackName == "TestApp")
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorState == nil)
        #expect(viewModel.resultMessage.contains("Name taken"))
    }
    
    @Test("Search by name with no exact match shows similar results")
    func searchByNameNoExactMatch() async throws {
        // Arrange
        let mockService = MockAppStoreService()
        let mockApp = AppResult(
            trackId: 1,
            trackName: "TestApp Pro",
            artistName: "Test Developer",
            description: nil,
            artworkUrl100: nil,
            averageUserRating: nil,
            userRatingCount: nil,
            primaryGenreName: nil
        )
        let mockResponse = AppStoreSearchResponse(resultCount: 1, results: [mockApp])
        mockService.searchByNameResult = .success(mockResponse)
        
        let viewModel = AppSearchViewModel(service: mockService)
        viewModel.searchText = "TestApp"
        viewModel.searchMode = .name
        
        // Act
        await viewModel.performSearch()
        
        // Assert
        #expect(viewModel.searchResults.count == 1)
        #expect(viewModel.exactNameMatch == nil)
        #expect(viewModel.resultMessage.contains("available"))
        #expect(viewModel.resultMessage.contains("similar"))
    }
    
    @Test("Search by description returns matching apps")
    func searchByDescription() async throws {
        // Arrange
        let mockService = MockAppStoreService()
        let mockApps = [
            AppResult(trackId: 1, trackName: "App1", artistName: "Dev1", description: "Task manager", artworkUrl100: nil, averageUserRating: nil, userRatingCount: nil, primaryGenreName: nil),
            AppResult(trackId: 2, trackName: "App2", artistName: "Dev2", description: "Task tracker", artworkUrl100: nil, averageUserRating: nil, userRatingCount: nil, primaryGenreName: nil)
        ]
        let mockResponse = AppStoreSearchResponse(resultCount: 2, results: mockApps)
        mockService.searchByDescriptionResult = .success(mockResponse)
        
        let viewModel = AppSearchViewModel(service: mockService)
        viewModel.searchText = "task management app"
        viewModel.searchMode = .description
        
        // Act
        await viewModel.performSearch()
        
        // Assert
        #expect(viewModel.searchResults.count == 2)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.errorState == nil)
        #expect(viewModel.resultMessage.contains("2 app(s)"))
    }
    
    // MARK: - Empty State Tests
    
    @Test("Search by name with no results shows name available")
    func searchByNameNoResults() async throws {
        // Arrange
        let mockService = MockAppStoreService()
        let mockResponse = AppStoreSearchResponse(resultCount: 0, results: [])
        mockService.searchByNameResult = .success(mockResponse)
        
        let viewModel = AppSearchViewModel(service: mockService)
        viewModel.searchText = "UniqueAppName123"
        viewModel.searchMode = .name
        
        // Act
        await viewModel.performSearch()
        
        // Assert
        #expect(viewModel.searchResults.isEmpty)
        #expect(viewModel.exactNameMatch == nil)
        #expect(viewModel.resultMessage.contains("available"))
    }
    
    @Test("Search by description with no results")
    func searchByDescriptionNoResults() async throws {
        // Arrange
        let mockService = MockAppStoreService()
        let mockResponse = AppStoreSearchResponse(resultCount: 0, results: [])
        mockService.searchByDescriptionResult = .success(mockResponse)
        
        let viewModel = AppSearchViewModel(service: mockService)
        viewModel.searchText = "very unique description"
        viewModel.searchMode = .description
        
        // Act
        await viewModel.performSearch()
        
        // Assert
        #expect(viewModel.searchResults.isEmpty)
        #expect(viewModel.resultMessage.contains("No similar apps found"))
    }
    
    @Test("Empty search text clears results")
    func emptySearchTextClearsResults() async throws {
        // Arrange
        let mockService = MockAppStoreService()
        let viewModel = AppSearchViewModel(service: mockService)
        viewModel.searchText = ""
        
        // Act
        await viewModel.performSearch()
        
        // Assert
        #expect(viewModel.searchResults.isEmpty)
        #expect(viewModel.errorState == nil)
        #expect(viewModel.isLoading == false)
    }
    
    // MARK: - Error State Tests
    
    @Test("Network error is handled correctly")
    func networkError() async throws {
        // Arrange
        let mockService = MockAppStoreService()
        mockService.searchByNameResult = .failure(AppError.networkUnavailable)
        
        let viewModel = AppSearchViewModel(service: mockService)
        viewModel.searchText = "TestApp"
        viewModel.searchMode = .name
        
        // Act
        await viewModel.performSearch()
        
        // Assert
        #expect(viewModel.errorState == AppError.networkUnavailable)
        #expect(viewModel.searchResults.isEmpty)
        #expect(viewModel.isLoading == false)
        #expect(viewModel.resultMessage.contains("internet connection"))
    }
    
    @Test("Invalid response error is handled correctly")
    func invalidResponseError() async throws {
        // Arrange
        let mockService = MockAppStoreService()
        mockService.searchByNameResult = .failure(AppError.invalidResponse)
        
        let viewModel = AppSearchViewModel(service: mockService)
        viewModel.searchText = "TestApp"
        viewModel.searchMode = .name
        
        // Act
        await viewModel.performSearch()
        
        // Assert
        #expect(viewModel.errorState == AppError.invalidResponse)
        #expect(viewModel.searchResults.isEmpty)
        #expect(viewModel.resultMessage.contains("unexpected response"))
    }
    
    @Test("Search failed error is handled correctly")
    func searchFailedError() async throws {
        // Arrange
        let mockService = MockAppStoreService()
        mockService.searchByDescriptionResult = .failure(AppError.searchFailed("Invalid query"))
        
        let viewModel = AppSearchViewModel(service: mockService)
        viewModel.searchText = "test"
        viewModel.searchMode = .description
        
        // Act
        await viewModel.performSearch()
        
        // Assert
        #expect(viewModel.errorState == AppError.searchFailed("Invalid query"))
        #expect(viewModel.resultMessage.contains("Search failed"))
    }
    
    // MARK: - Clear Functionality Tests
    
    @Test("Clear search resets all state")
    func clearSearchResetsState() async throws {
        // Arrange
        let mockService = MockAppStoreService()
        let mockResponse = AppStoreSearchResponse(resultCount: 1, results: [
            AppResult(trackId: 1, trackName: "Test", artistName: nil, description: nil, artworkUrl100: nil, averageUserRating: nil, userRatingCount: nil, primaryGenreName: nil)
        ])
        mockService.searchByNameResult = .success(mockResponse)
        
        let viewModel = AppSearchViewModel(service: mockService)
        viewModel.searchText = "TestApp"
        await viewModel.performSearch()
        
        // Act
        viewModel.clearSearch()
        
        // Assert
        #expect(viewModel.searchText.isEmpty)
        #expect(viewModel.searchResults.isEmpty)
        #expect(viewModel.errorState == nil)
    }
}
// MARK: - Model Tests

@Suite("AppStoreSearchResponse Model Tests")
struct AppStoreSearchResponseTests {
    
    @Test("AppStoreSearchResponse decodes correctly")
    func decodesCorrectly() throws {
        // Arrange
        let json = """
        {
            "resultCount": 1,
            "results": [
                {
                    "trackId": 123,
                    "trackName": "Test App",
                    "artistName": "Test Developer",
                    "description": "A test application",
                    "artworkUrl100": "https://example.com/icon.png",
                    "averageUserRating": 4.5,
                    "userRatingCount": 100,
                    "primaryGenreName": "Productivity"
                }
            ]
        }
        """
        
        // Act
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder()
        let response = try decoder.decode(AppStoreSearchResponse.self, from: data)
        
        // Assert
        #expect(response.resultCount == 1)
        #expect(response.results.count == 1)
        #expect(response.results[0].trackName == "Test App")
        #expect(response.results[0].artistName == "Test Developer")
    }
}

@Suite("AppError Tests")
struct AppErrorTests {
    
    @Test("AppError descriptions are user-friendly")
    func errorDescriptionsAreUserFriendly() {
        // Arrange & Act & Assert
        #expect(AppError.networkUnavailable.localizedDescription.contains("internet connection"))
        #expect(AppError.invalidResponse.localizedDescription.contains("unexpected response"))
        #expect(AppError.searchFailed("test").localizedDescription.contains("Search failed"))
        #expect(AppError.unknown.localizedDescription.contains("unexpected error"))
    }
}

