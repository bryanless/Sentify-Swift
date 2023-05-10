//
//  CommentThreadResponse.swift
//  
//
//  Created by Bryan on 09/05/23.
//

import Foundation

// MARK: - CommentThreadResponse
public struct CommentThreadResponse: Codable {
    let kind, etag, id: String
    let snippet: CommentThreadResponseSnippet
}

// MARK: - CommentThreadResponseSnippet
public struct CommentThreadResponseSnippet: Codable {
    let videoId: String
    let topLevelComment: TopLevelComment
    let canReply: Bool
    let totalReplyCount: Int
    let isPublic: Bool
}

// MARK: - TopLevelComment
public struct TopLevelComment: Codable {
    let kind, etag, id: String
    let snippet: TopLevelCommentSnippet
}

// MARK: - TopLevelCommentSnippet
public struct TopLevelCommentSnippet: Codable {
    let videoId, textDisplay, textOriginal, authorDisplayName: String
    let authorProfileImageUrl: String
    let authorChannelUrl: String
    let authorChannelId: AuthorChannelID
    let canRate: Bool
    let viewerRating: String
    let likeCount: Int
//    let publishedAt, updatedAt: Date
}

// MARK: - AuthorChannelID
public struct AuthorChannelID: Codable {
    let value: String
}
