//
//  YouTubeDataResponse.swift
//  
//
//  Created by Bryan on 09/05/23.
//

import Foundation

// MARK: - YouTubeDataResponse
public struct YouTubeDataResponse<Item: Codable>: Codable {
  let kind: String
  let etag: String
  let nextPageToken: String?
  let prevPageToken: String?
  let regionCode: String?
  let pageInfo: PageInfo
  let items: [Item]
}

// MARK: - PageInfo
public struct PageInfo: Codable {
  let totalResults: Int
  let resultsPerPage: Int
}

// MARK: - Thumbnails
public struct Thumbnails: Codable {
  public let thumbnailsDefault, medium, high: Default
  public let standard, maxres: Default?

  enum CodingKeys: String, CodingKey {
    case thumbnailsDefault = "default"
    case medium, high, standard
    case maxres
  }
}

// MARK: - Default
public struct Default: Codable {
  public let url: String
  public let width, height: Int
}
