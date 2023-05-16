//
//  CommentSentimentModel.swift
//  Sentify
//
//  Created by Bryan on 16/05/23.
//

import Foundation

public struct CommentSentimentModel: Equatable, Identifiable {

  public let id: String
  public let videoId: String
  public let title: String
  public let authorDisplayName: String
  public let authorProfileImageUrl: String
  public let tagName: String
  public let confidence: String

  public init(
    id: String,
    videoId: String,
    title: String,
    authorDisplayName: String,
    authorProfileImageUrl: String,
    tagName: String,
    confidence: String
  ) {
    self.id = id
    self.videoId = videoId
    self.title = title
    self.authorDisplayName = authorDisplayName
    self.authorProfileImageUrl = authorProfileImageUrl
    self.tagName = tagName
    self.confidence = confidence
  }

}
