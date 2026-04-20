//
//  AppResultRow.swift
//  AlreadyExists?
//
//  Created by richard Haynes on 4/19/26.
//

import SwiftUI

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
    List {
        AppResultRow(
            app: AppResult(
                trackId: 1,
                trackName: "Example App",
                artistName: "Example Developer",
                description: "An example app",
                artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Purple116/v4/48/97/54/489754c1-4d7d-b5b4-e32e-74b2e4a66e73/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/100x100bb.jpg",
                averageUserRating: 4.5,
                userRatingCount: 1234,
                primaryGenreName: "Productivity"
            ),
            isExactMatch: true
        )
        
        AppResultRow(
            app: AppResult(
                trackId: 2,
                trackName: "Another App",
                artistName: "Another Developer",
                description: nil,
                artworkUrl100: nil,
                averageUserRating: nil,
                userRatingCount: nil,
                primaryGenreName: "Games"
            ),
            isExactMatch: false
        )
    }
}
