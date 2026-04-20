//
//  ContentView.swift
//  AlreadyExists?
//
//  Created by richard Haynes on 4/18/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = AppSearchViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Search Mode Picker
                Picker("Search Mode", selection: $viewModel.searchMode) {
                    ForEach(AppSearchViewModel.SearchMode.allCases, id: \.self) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                // Search Input
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.searchMode == .name ? "App Name" : "App Description")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    TextField(
                        viewModel.searchMode == .name ? "Enter app name..." : "Paste app description...",
                        text: $viewModel.searchText,
                        axis: viewModel.searchMode == .description ? .vertical : .horizontal
                    )
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(viewModel.searchMode == .description ? 3...6 : 1...1)
                    .submitLabel(.search)
                    .onSubmit {
                        Task {
                            await viewModel.performSearch()
                        }
                    }
                }
                .padding(.horizontal)
                
                // Search Button
                Button {
                    Task {
                        await viewModel.performSearch()
                    }
                } label: {
                    HStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .tint(.white)
                        } else {
                            Image(systemName: "magnifyingglass")
                        }
                        Text("Search")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.searchText.isEmpty ? Color.gray : Color.accentColor)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .disabled(viewModel.searchText.isEmpty || viewModel.isLoading)
                .padding(.horizontal)
                
                // Result Message
                if !viewModel.resultMessage.isEmpty {
                    VStack(spacing: 12) {
                        Text(viewModel.resultMessage)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(resultBackgroundColor)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal)
                        
                        // Show results list if in description mode or if similar names found
                        if !viewModel.searchResults.isEmpty && (viewModel.searchMode == .description || viewModel.exactNameMatch == nil) {
                            Button {
                                // Could navigate to detail view
                            } label: {
                                Text("View \(viewModel.searchResults.count) Result(s)")
                                    .font(.subheadline)
                                    .foregroundStyle(.blue)
                            }
                        }
                    }
                }
                
                // Results List
                if !viewModel.searchResults.isEmpty && !viewModel.isLoading {
                    List(viewModel.searchResults) { app in
                        AppResultRow(app: app, isExactMatch: app.id == viewModel.exactNameMatch?.id)
                    }
                    .listStyle(.plain)
                }
                
                Spacer()
            }
            .navigationTitle("AlreadyExists?")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !viewModel.searchText.isEmpty {
                        Button("Clear") {
                            viewModel.clearSearch()
                        }
                    }
                }
            }
        }
    }
    
    private var resultBackgroundColor: Color {
        if viewModel.errorState != nil {
            return Color.red.opacity(0.1)
        }
        
        if viewModel.searchMode == .name && viewModel.exactNameMatch != nil {
            return Color.red.opacity(0.1)
        }
        
        if viewModel.searchMode == .name && viewModel.exactNameMatch == nil && !viewModel.searchResults.isEmpty {
            return Color.orange.opacity(0.1)
        }
        
        if viewModel.searchMode == .name && viewModel.searchResults.isEmpty {
            return Color.green.opacity(0.1)
        }
        
        return Color.blue.opacity(0.1)
    }
}

// MARK: - App Result Row

/// Row view for displaying individual app search results
struct AppResultRow: View {
    let app: AppResult
    let isExactMatch: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // App Icon
            if let artworkUrl = app.artworkUrl100, let url = URL(string: artworkUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.2))
                }
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(app.trackName)
                        .font(.headline)
                    
                    if isExactMatch {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(.red)
                            .font(.caption)
                    }
                }
                
                if let artist = app.artistName {
                    Text(artist)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                if let genre = app.primaryGenreName {
                    Text(genre)
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                }
                
                if let rating = app.averageUserRating, let count = app.userRatingCount {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.caption2)
                            .foregroundStyle(.yellow)
                        Text(String(format: "%.1f", rating))
                            .font(.caption)
                        Text("(\(count))")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    ContentView()
}
