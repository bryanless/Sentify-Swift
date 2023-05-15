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
  VideoRepository: Repository,
  CommentThreadRepository: Repository>: ObservableObject
where VideoRepository.Request == VideoRequest,
      VideoRepository.Response == [VideoModel],
      CommentThreadRepository.Request == CommentThreadRequest,
      CommentThreadRepository.Response == [CommentThreadModel] {

  private var cancellables: Set<AnyCancellable> = []

  private let _videoRepository: VideoRepository
  private let _commentThreadRepository: CommentThreadRepository

  @Published public var videoId: String = ""
  @Published public var item: CommentSentimentAnalysisModel?
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false

  public init(
    videoRepository: VideoRepository,
    commentThreadRepository: CommentThreadRepository
  ) {
    self._videoRepository = videoRepository
    self._commentThreadRepository = commentThreadRepository
  }

  func getSentimentAnalysis(request: String) {
    isLoading = true

    let videoRequest = VideoRequest(id: request)
    let commentThreadRequest = CommentThreadRequest(videoId: request)

    let videoPublisher = _videoRepository.execute(request: videoRequest)
    let commentPublisher = _commentThreadRepository.execute(request: commentThreadRequest)

    let loadingPublishers = Publishers.CombineLatest(
      videoPublisher,
      commentPublisher)

    loadingPublishers
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
      }, receiveValue: { sentimentAnalysis in
        self.isError = false

        let video = sentimentAnalysis.0.first!

        self.item = CommentSentimentAnalysisModel(
          video: video,
          commentThreads: sentimentAnalysis.1)
      })
      .store(in: &cancellables)
  }
}
