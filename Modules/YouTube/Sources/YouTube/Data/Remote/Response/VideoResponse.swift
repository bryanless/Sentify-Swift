//
//  VideoResponse.swift
//  
//
//  Created by Bryan on 09/05/23.
//

import Foundation

// MARK: - VideoResponse
public struct VideoResponse: Codable {
  let kind, etag, id: String
  let snippet: VideoSnippet?
}

// MARK: - VideoSnippet
public struct VideoSnippet: Codable {
  //    let publishedAt: Date
  //  let channelId: String
  let title, description: String
  let thumbnails: Thumbnails
  let channelTitle: String
  //    let tags: [String]
  //    let categoryId, liveBroadcastContent: String
  //    let localized: Localized
}

// MARK: - Localized
public struct Localized: Codable {
  let title, description: String
}
