//
//  SearchCommentView.swift
//  Sentify
//
//  Created by Bryan on 09/05/23.
//

import Common
import Core
import SwiftUI
import YouTube

struct SearchCommentView: View {
  @ObservedObject private var viewModel: SearchCommentViewModel<
    GetCommentThreadRepository<
      GetCommentThreadLocaleDataSource,
      GetCommentThreadRemoteDataSource,
      CommentThreadTransformer>>
  @FocusState private var isSearchBarFocused: Bool
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
    ZStack {
      if viewModel.isLoading {
        ProgressIndicator()
          .background(CustomColor.background)
      } else if viewModel.isError {
        CustomEmptyView(label: viewModel.errorMessage)
      } else if viewModel.items.isEmpty {
        empty
      } else {
        content
      }
    }
    .safeAreaInset(edge: .top) {
      search
    }
    .simultaneousGesture(tapGesture)
    .simultaneousGesture(dragGesture)
  }
}

extension SearchCommentView {
  var tapGesture: some Gesture {
    TapGesture()
      .onEnded {
        isSearchBarFocused = false
      }
  }

  var dragGesture: some Gesture {
    DragGesture()
      .onChanged { _ in
        isSearchBarFocused = false
      }
  }

  var search: some View {
    VStack(spacing: Space.medium) {
      //      Text("Analyze Sentiment of YouTube comments")
      //        .typography(.headline())
      //        .multilineTextAlignment(.center)
      SearchField(
        placeholder: "Enter YouTube link",
        searchText: $viewModel.videoId,
        isFocused: _isSearchBarFocused)
      .textInputAutocapitalization(.never)
      .onSubmit(of: .text) {
        viewModel.getCommentThreads(request: CommentThreadRequest(videoId: viewModel.videoId))
      }
      //      Button {
      //        viewModel.getCommentThreads(request: CommentThreadRequest(videoId: viewModel.channelName))
      //      } label: {
      //        HStack {
      //          Spacer()
      //          Text("Analyze comments")
      //          Spacer()
      //        }
      //      }
      //      .buttonStyle(FilledButton())
    }
    .padding()
    .background(scrollOffset > 1 ? CustomColor.surface2 : CustomColor.background)
  }

  var empty: some View {
    CustomEmptyView(label: "Nothing to show")
  }

  var content: some View {
    ObservableScrollView(scrollOffset: $scrollOffset) {
      CommentListView(comments: viewModel.items)
        .padding()
    }
    .background(CustomColor.background)
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
        commentThreadRepository: Injection(inMemory: true).provideCommentThread()))
  }
}
