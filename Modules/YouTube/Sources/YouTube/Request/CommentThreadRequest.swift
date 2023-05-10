//
//  CommentThreadRequest.swift
//  
//
//  Created by Bryan on 10/05/23.
//

public struct CommentThreadRequest {
  let part: String
  let videoId: String

  public init(
    part: String = "snippet",
    videoId: String
  ) {
    self.part = part
    self.videoId = videoId
  }
}
