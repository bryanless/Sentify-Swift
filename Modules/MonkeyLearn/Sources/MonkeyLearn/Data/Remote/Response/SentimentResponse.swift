//
//  SentimentResponse.swift
//  
//
//  Created by Bryan on 15/05/23.
//

import Foundation

// MARK: - SentimentResponse
public struct SentimentResponse: Codable {
  public let text: String
  public let classifications: [SentimentClassification]
}

// MARK: - SentimentClassification
public struct SentimentClassification: Codable {
  public let tagName, confidence: String

  enum CodingKeys: String, CodingKey {
    case tagName = "tag_name"
    case confidence
  }
}
