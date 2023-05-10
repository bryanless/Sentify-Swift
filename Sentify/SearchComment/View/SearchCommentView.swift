//
//  SearchCommentView.swift
//  Sentify
//
//  Created by Bryan on 09/05/23.
//

import Common
import SwiftUI
import YouTube

struct SearchCommentView: View {
  @ObservedObject private var viewModel: SearchCommentViewModel<
    GetCommentThreadRepository<
      GetCommentThreadLocaleDataSource,
      GetCommentThreadRemoteDataSource,
      CommentThreadTransformer>>

  init(
    viewModel: SearchCommentViewModel<
    GetCommentThreadRepository<
    GetCommentThreadLocaleDataSource,
    GetCommentThreadRemoteDataSource,
    CommentThreadTransformer>>
  ) {
    self.viewModel = viewModel
  }

  var body: some View {
    VStack {
      Text("Analyze Sentiment of YouTube comments")
        .typography(.title())
        .multilineTextAlignment(.center)
      SearchField(
        placeholder: "YouTube link",
        searchText: $viewModel.channelName)
        .textInputAutocapitalization(.never)
      Button {
        viewModel.getCommentThreads(request: CommentThreadRequest(videoId: viewModel.channelName))
      } label: {
        HStack {
          Spacer()
          Text("Analyze comments")
          Spacer()
        }
      }
      .buttonStyle(FilledButton())
      CommentListView(comments: viewModel.items)
    }
    .padding()
  }
}

struct SearchCommentView_Previews: PreviewProvider {
  static var previews: some View {
    SearchCommentView(
      viewModel: SearchCommentViewModel<
      GetCommentThreadRepository<
      GetCommentThreadLocaleDataSource,
      GetCommentThreadRemoteDataSource,
      CommentThreadTransformer>>(
        commentThreadRepository: Injection().provideCommentThread()))
  }
}
