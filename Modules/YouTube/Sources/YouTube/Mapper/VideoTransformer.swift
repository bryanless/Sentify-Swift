//
//  VideoTransformer.swift
//  
//
//  Created by Bryan on 15/05/23.
//

import Core
import Foundation

public struct VideoTransformer: Mapper {

  public typealias Request = Any
  public typealias Response = [VideoResponse]
  public typealias Entity = [VideoEntity]
  public typealias Domain = [VideoModel]

  public init() {}

  public func transformResponseToEntity(request: Any?, response: [VideoResponse]) -> [VideoEntity] {
    return response.map { result in
      let videoEntity = VideoEntity()
      videoEntity.id = result.id
      videoEntity.channelTitle = result.snippet.channelTitle
      videoEntity.title = result.snippet.title
      videoEntity.thumbnailsMedium = result.snippet.thumbnails.medium.url
      return videoEntity
    }
  }

  public func transformEntityToDomain(entity: [VideoEntity]) -> [VideoModel] {
    return entity.map { result in
      return VideoModel(
        id: result.id,
        channelTitle: result.channelTitle,
        title: result.title,
        thumbnailsMedium: result.thumbnailsMedium)
    }
  }
}
