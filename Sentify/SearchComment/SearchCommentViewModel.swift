//
//  SearchCommentViewModel.swift
//  Sentify
//
//  Created by Bryan on 09/05/23.
//

import Combine
import Core
import Foundation
import YouTube

class SearchCommentViewModel<
  CommentThreadRepository: Repository>: ObservableObject
where CommentThreadRepository.Request == CommentThreadRequest,
      CommentThreadRepository.Response == [CommentThreadModel] {

  private var cancellables: Set<AnyCancellable> = []

  private let _commentThreadRepository: CommentThreadRepository

  @Published public var channelName: String = ""
  @Published public var items: [CommentThreadModel] = []
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false

  public init(
    commentThreadRepository: CommentThreadRepository
  ) {
    self._commentThreadRepository = commentThreadRepository
  }

  func getCommentThreads(request: CommentThreadRepository.Request) {
    isLoading = true
    _commentThreadRepository.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { comments in
        self.items = comments
      })
      .store(in: &cancellables)
  }
}
