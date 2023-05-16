//
//  YouTubeSentimentModel.swift
//  Sentify
//
//  Created by Bryan on 15/05/23.
//

import YouTube

public struct YouTubeSentimentModel {
  public let video: VideoModel
  public let commentSentiments: [CommentSentimentModel]

  public init(video: VideoModel, commentSentiments: [CommentSentimentModel]) {
    self.video = video
    self.commentSentiments = commentSentiments
  }
}
