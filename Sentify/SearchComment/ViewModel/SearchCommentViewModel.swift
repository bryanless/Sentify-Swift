//
//  SearchCommentViewModel.swift
//  Sentify
//
//  Created by Bryan on 09/05/23.
//

import Combine
import Core
import Foundation
import MonkeyLearn
import YouTube

class SearchCommentViewModel<
  VideoRepository: Repository>: ObservableObject
where VideoRepository.Request == VideoRequest,
      VideoRepository.Response == [VideoModel] {

  private var cancellables: Set<AnyCancellable> = []

  private let _videoRepository: VideoRepository
  private let _commentSentimentRepository: GetCommentSentimentRepository<
    GetCommentSentimentLocaleDataSource,
    GetCommentThreadRemoteDataSource,
    GetSentimentRemoteDataSource>

  @Published public var videoId: String = ""
  @Published public var item: YouTubeSentimentModel?
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false

  public init(
    videoRepository: VideoRepository,
    commentSentimentRepository: GetCommentSentimentRepository<
    GetCommentSentimentLocaleDataSource,
    GetCommentThreadRemoteDataSource,
    GetSentimentRemoteDataSource>
  ) {
    self._videoRepository = videoRepository
    self._commentSentimentRepository = commentSentimentRepository
  }

  func getSentimentAnalysis(request: String) {
    guard !request.isEmpty else {
      return
    }

    isLoading = true

    var videoId: String = ""

    if request.contains("/"),
       let urlComponents = URLComponents(string: request) {
      if let id = urlComponents.queryItems?.first(where: { $0.name == "v" })?.value {
        videoId = id
      } else {
        let path = urlComponents.path
        let range = path.range(of: "/", options: [.regularExpression, .backwards])!
        videoId = String(path[range.upperBound...])
      }
    } else {
      videoId = request
    }

    let videoRequest = VideoRequest(id: videoId)
    let commentThreadRequest = CommentThreadRequest(videoId: videoId)

    let videoPublisher = _videoRepository.execute(request: videoRequest)
    let commentPublisher = _commentSentimentRepository.execute(request: commentThreadRequest)

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

        self.item = YouTubeSentimentModel(
          video: video,
          commentSentiments: sentimentAnalysis.1)
      })
      .store(in: &cancellables)
  }
}
