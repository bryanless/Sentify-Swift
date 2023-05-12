//
//  CommentThreadRequest.swift
//  
//
//  Created by Bryan on 10/05/23.
//

public struct CommentThreadRequest {
  let part: String
  let videoId: String
  let order: CommentThreadOrderRequest

  public init(
    part: String = "snippet",
    videoId: String,
    order: CommentThreadOrderRequest = .time
  ) {
    self.part = part
    self.videoId = videoId
    self.order = order
  }
}

public enum CommentThreadOrderRequest: String {
  case time
  case relevance

  var name: String {
    return rawValue.lowercased()
  }

  var sortKey: String {
    switch self {
    case .time:
      return "publishedAt"
    case .relevance:
      // TODO Change sort key for relevance order
      return "publishedAt"
    }
  }
}
