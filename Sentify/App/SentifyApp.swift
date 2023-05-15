//
//  SentifyApp.swift
//  Sentify
//
//  Created by Bryan on 08/05/23.
//

import SwiftUI
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

@main
struct SentifyApp: App {

  let searchCommentViewModel = SearchCommentViewModel(
    videoRepository: videoRepository,
    commentThreadRepository: commentThreadRepository)

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(searchCommentViewModel)
    }
  }
}
