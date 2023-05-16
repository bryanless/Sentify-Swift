//
//  CommentSentimentTransformer.swift
//  Sentify
//
//  Created by Bryan on 16/05/23.
//

import Foundation
import MonkeyLearn
import YouTube

public struct CommentSentimentTransformer {

  public func transformResponseToEntity(
    request: Any?,
    commentResponse: [CommentThreadResponse],
    sentimentResponse: [SentimentResponse]) -> [CommentSentimentEntity] {
      return commentResponse.map { result in
        let sentiment = sentimentResponse
          .first(where: { $0.text == result.snippet.topLevelComment.snippet.textOriginal })!

        let commentSentimentEntity = CommentSentimentEntity()
        commentSentimentEntity.id = result.id
        commentSentimentEntity.videoId = result.snippet.videoId
        commentSentimentEntity.title = result.snippet.topLevelComment.snippet.textOriginal
        commentSentimentEntity.authorDisplayName = result.snippet.topLevelComment.snippet.authorDisplayName
        commentSentimentEntity.authorProfileImageUrl = result.snippet.topLevelComment.snippet.authorProfileImageUrl
        commentSentimentEntity.tagName = sentiment.classifications.first!.tagName
        commentSentimentEntity.confidence = sentiment.classifications.first!.confidence
        return commentSentimentEntity
      }
    }
  public func transformEntityToDomain(entity: [CommentSentimentEntity]) -> [CommentSentimentModel] {
      return entity.map { result in
        return CommentSentimentModel(
          id: result.id,
          videoId: result.videoId,
          title: result.title,
          authorDisplayName: result.authorDisplayName,
          authorProfileImageUrl: result.authorProfileImageUrl,
          tagName: result.tagName,
          confidence: result.confidence)
      }
    }

}
