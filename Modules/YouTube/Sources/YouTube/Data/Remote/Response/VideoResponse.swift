//
//  VideoResponse.swift
//  
//
//  Created by Bryan on 09/05/23.
//

import Foundation

// MARK: - VideoResponse
public struct VideoResponse: Codable {
  public let kind, etag, id: String
  public let snippet: VideoSnippet
}

// MARK: - VideoSnippet
public struct VideoSnippet: Codable {
  public let publishedAt: String
  public let title, description: String
  public let thumbnails: Thumbnails
  public let channelTitle: String
}

// MARK: - Localized
public struct Localized: Codable {
  public let title, description: String
}
