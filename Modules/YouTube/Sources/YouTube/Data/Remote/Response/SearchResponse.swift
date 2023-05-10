//
//  SearchResponse.swift
//  
//
//  Created by Bryan on 09/05/23.
//

import Foundation

// MARK: - SearchResponse
public struct SearchResponse: Codable {
  let kind, etag: String
  let id: SearchResponseId
  let snippet: SearchSnippet
}

// MARK: - SearchResponseId
public struct SearchResponseId: Codable {
  let kind: String
  let videoId, channelId, playlistId: String?
}

// MARK: - SearchSnippet
public struct SearchSnippet: Codable {
  let publishedAt: Date
  let channelId, title, description: String
  let thumbnails: Thumbnails
  let channelTitle, playlistID: String
  let position: Int
  let resourceId: ResourceId
  let videoOwnerChannelTitle, videoOwnerChannelId: String
}

// MARK: - ResourceId
public struct ResourceId: Codable {
  let kind, videoId: String
}
