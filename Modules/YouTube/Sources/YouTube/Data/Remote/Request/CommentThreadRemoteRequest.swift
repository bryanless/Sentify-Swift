//
//  CommentThreadRemoteRequest.swift
//  
//
//  Created by Bryan on 09/05/23.
//

import Foundation

public struct CommentThreadRemoteRequest: Encodable {
  let part: String
  let videoId: String?
  let order: String
  let key: String

  public init(
    part: String = "snippet",
    videoId: String?,
    order: String = "time",
    key: String
  ) {
    self.part = part
    self.videoId = videoId
    self.order = order
    self.key = key
  }
}
