//
//  ContentView.swift
//  Sentify
//
//  Created by Bryan on 08/05/23.
//

import Common
import Core
import SwiftUI
import YouTube

struct ContentView: View {
  @EnvironmentObject private var searchCommentViewModel: SearchCommentViewModel<
    GetVideoRepository<
      GetVideoLocaleDataSource,
      GetVideoRemoteDataSource,
      VideoTransformer>>
  @State private var selection: Tab = .search

  init() {
    NetworkMonitor.shared.startMonitoring()

    UITabBar.appearance().isHidden = true
  }

  var body: some View {
    CustomNavigationView {
      SearchCommentView(viewModel: searchCommentViewModel)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static let injection = Injection.init()

  static let commentThreadRepository: GetCommentThreadRepository<
    GetCommentThreadLocaleDataSource,
    GetCommentThreadRemoteDataSource,
    CommentThreadTransformer> = injection.provideCommentThread()

  static var previews: some View {
    ContentView()
      .environmentObject(
        SearchCommentViewModel<
        GetVideoRepository<
        GetVideoLocaleDataSource,
        GetVideoRemoteDataSource,
        VideoTransformer>>(
          videoRepository: videoRepository,
          commentSentimentRepository: commentSentimentRepository))
  }
}
