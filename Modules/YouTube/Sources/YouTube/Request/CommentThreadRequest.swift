//
//  CommentThreadRequest.swift
//  
//
//  Created by Bryan on 10/05/23.
//

public struct CommentThreadRequest {
  public let part: String
  public let videoId: String
  public let order: CommentThreadOrderRequest

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

  public var name: String {
    return rawValue.lowercased()
  }

  public var sortKey: String {
    switch self {
    case .time:
      return "publishedAt"
    case .relevance:
      // TODO Change sort key for relevance order
      return "publishedAt"
    }
  }
}
