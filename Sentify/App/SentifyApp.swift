//
//  SentifyApp.swift
//  Sentify
//
//  Created by Bryan on 08/05/23.
//

import SwiftUI
import MonkeyLearn
import YouTube

let injection = Injection.init()

let videoRepository: GetVideoRepository<
    GetVideoLocaleDataSource,
    GetVideoRemoteDataSource,
    VideoTransformer> = injection.provideVideo()

let commentThreadRepository: GetCommentThreadRepository<
    GetCommentThreadLocaleDataSource,
    GetCommentThreadRemoteDataSource,
    CommentThreadTransformer> = injection.provideCommentThread()

let commentSentimentRepository = injection.provideCommentSentiment()

@main
struct SentifyApp: App {

  let searchCommentViewModel = SearchCommentViewModel(
    videoRepository: videoRepository,
    commentSentimentRepository: commentSentimentRepository)

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(searchCommentViewModel)
    }
  }
}
