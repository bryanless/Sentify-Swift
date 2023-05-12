//
//  CommentThreadTransformer.swift
//  
//
//  Created by Bryan on 10/05/23.
//

import Core
import Foundation

public struct CommentThreadTransformer: Mapper {

  public typealias Request = Any
  public typealias Response = [CommentThreadResponse]
  public typealias Entity = [CommentThreadEntity]
  public typealias Domain = [CommentThreadModel]

  public init() {}

  public func transformResponseToEntity(request: Any?, response: [CommentThreadResponse]) -> [CommentThreadEntity] {
    return response.map { result in
      let commentThreadEntity = CommentThreadEntity()
      commentThreadEntity.id = result.id
      commentThreadEntity.videoId = result.snippet.videoId
      commentThreadEntity.title = result.snippet.topLevelComment.snippet.textOriginal
      commentThreadEntity.authorDisplayName = result.snippet.topLevelComment.snippet.authorDisplayName
      commentThreadEntity.authorProfileImageUrl = result.snippet.topLevelComment.snippet.authorProfileImageUrl
      return commentThreadEntity
    }
  }

  public func transformEntityToDomain(entity: [CommentThreadEntity]) -> [CommentThreadModel] {
    return entity.map { result in
      return CommentThreadModel(
        id: result.id,
        videoId: result.videoId,
        title: result.title,
        authorDisplayName: result.authorDisplayName,
        authorProfileImageUrl: result.authorProfileImageUrl)
    }
  }
}
