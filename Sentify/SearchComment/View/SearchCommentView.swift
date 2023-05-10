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
  @State var scrollOffset: CGFloat

  init(
    viewModel: SearchCommentViewModel<
    GetCommentThreadRepository<
    GetCommentThreadLocaleDataSource,
    GetCommentThreadRemoteDataSource,
    CommentThreadTransformer>>,
    scrollOffset: CGFloat = CGFloat.zero
  ) {
    self.viewModel = viewModel
    self.scrollOffset = scrollOffset
  }

  var body: some View {
    NavigationBarScrollView(scrollOffset: $scrollOffset) {
      Text("")
    } content: {
      content
    }
  }
}

extension SearchCommentView {
  var content: some View {
    VStack(spacing: Space.medium) {
      Text("Analyze Sentiment of YouTube comments")
        .typography(.headline())
        .multilineTextAlignment(.center)
      SearchField(
        placeholder: "Enter YouTube link",
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
