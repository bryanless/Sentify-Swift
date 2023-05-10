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
  let key: String

  public init(
    part: String = "snippet",
    videoId: String?,
    key: String
  ) {
    self.part = part
    self.videoId = videoId
    self.key = key
  }
}
