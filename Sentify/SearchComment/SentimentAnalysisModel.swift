//
//  SentimentAnalysisModel.swift
//  Sentify
//
//  Created by Bryan on 15/05/23.
//

import YouTube

public struct SentimentAnalysisModel {
  public let video: VideoModel
  public let commentThreads: [CommentThreadModel]

  public init(video: VideoModel, commentThreads: [CommentThreadModel]) {
    self.video = video
    self.commentThreads = commentThreads
  }
}
