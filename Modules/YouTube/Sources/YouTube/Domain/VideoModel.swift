//
//  VideoModel.swift
//  
//
//  Created by Bryan on 15/05/23.
//

public struct VideoModel: Equatable, Identifiable {

  public let id: String
  public let channelTitle: String
  public let title: String
  public let thumbnailsMedium: String

  public init(id: String, channelTitle: String, title: String, thumbnailsMedium: String) {
    self.id = id
    self.channelTitle = channelTitle
    self.title = title
    self.thumbnailsMedium = thumbnailsMedium
  }

}
