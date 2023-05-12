//
//  CommentThreadModel.swift
//  
//
//  Created by Bryan on 10/05/23.
//

public struct CommentThreadModel: Equatable, Identifiable {

  public let id: String
  public let videoId: String
  public let title: String
  public let authorDisplayName: String
  public let authorProfileImageUrl: String

  public init(id: String, videoId: String, title: String, authorDisplayName: String, authorProfileImageUrl: String) {
    self.id = id
    self.videoId = videoId
    self.title = title
    self.authorDisplayName = authorDisplayName
    self.authorProfileImageUrl = authorProfileImageUrl
  }

}
