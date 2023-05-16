//
//  CommentThreadResponse.swift
//  
//
//  Created by Bryan on 09/05/23.
//

import Foundation

// MARK: - CommentThreadResponse
public struct CommentThreadResponse: Codable {
  public let kind, etag, id: String
  public let snippet: CommentThreadResponseSnippet
}

// MARK: - CommentThreadResponseSnippet
public struct CommentThreadResponseSnippet: Codable {
  public let videoId: String
  public let topLevelComment: TopLevelComment
  public let canReply: Bool
  public let totalReplyCount: Int
  public let isPublic: Bool
}

// MARK: - TopLevelComment
public struct TopLevelComment: Codable {
  public let kind, etag, id: String
  public let snippet: TopLevelCommentSnippet
}

// MARK: - TopLevelCommentSnippet
public struct TopLevelCommentSnippet: Codable {
  public let videoId, textOriginal, authorDisplayName: String
  public let authorProfileImageUrl: String
  public let publishedAt: String
}
