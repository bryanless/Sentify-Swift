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
      commentThreadEntity.title = result.snippet.topLevelComment.snippet.textOriginal
      return commentThreadEntity
    }
  }

  public func transformEntityToDomain(entity: [CommentThreadEntity]) -> [CommentThreadModel] {
    return entity.map { result in
      return CommentThreadModel(
        id: result.id,
        title: result.title)
    }
  }
}
