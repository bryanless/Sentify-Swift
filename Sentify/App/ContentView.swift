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
    GetCommentThreadRepository<
      GetCommentThreadLocaleDataSource,
      GetCommentThreadRemoteDataSource,
      CommentThreadTransformer>>
  @State private var selection: Tab = .search

  init() {
    NetworkMonitor.shared.startMonitoring()

    UITabBar.appearance().isHidden = true
  }

  var body: some View {
    CustomNavigationView {
      SearchCommentView(viewModel: searchCommentViewModel)
    }
    //    VStack(spacing: 0) {
    //      TabView(selection: $selection) {
    //        CustomNavigationView {
    //          AnalyzeSentimentView()
    //        }
    //        .tag(Tab.search)
    //
    //        CustomNavigationView {
    //          SentimentAnalysisHistoryView()
    //        }
    //        .tag(Tab.history)
    //      }
    //
    //      TabBar(selection: $selection)
    //    }
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
      .environmentObject(SearchCommentViewModel(commentThreadRepository: commentThreadRepository))
  }
}
