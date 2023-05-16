//
//  GetCommentSentimentRepository.swift
//  Sentify
//
//  Created by Bryan on 16/05/23.
//

import Combine
import Core
import MonkeyLearn
import YouTube

public struct GetCommentSentimentRepository<
  CommentSentimentLocaleDataSource: LocaleDataSource,
  CommentRemoteDataSource: DataSource,
  SentimentDataSource: DataSource>
where CommentSentimentLocaleDataSource.Request == CommentThreadRequest,
      CommentSentimentLocaleDataSource.Response == CommentSentimentEntity {

  public typealias Request = CommentThreadRequest
  public typealias Response = CommentSentimentModel

  private let _localeDataSource: CommentSentimentLocaleDataSource
  private let _commentRemoteDataSource: CommentRemoteDataSource
  private let _sentimentRemoteDataSource: SentimentDataSource
  private let _mapper: CommentSentimentTransformer

  public init(
    localeDataSource: CommentSentimentLocaleDataSource,
    commentRemoteDataSource: CommentRemoteDataSource,
    sentimentRemoteDataSource: SentimentDataSource,
    mapper: CommentSentimentTransformer
  ) {
    _localeDataSource = localeDataSource
    _commentRemoteDataSource = commentRemoteDataSource
    _sentimentRemoteDataSource = sentimentRemoteDataSource
    _mapper = mapper
  }

  public func execute(request: CommentThreadRequest?) -> AnyPublisher<[CommentSentimentModel], Error> {
    guard let request = request else {
      fatalError("Request cannot be empty")
    }

    let commentThreadRequest = request as! CommentRemoteDataSource.Request

    return _commentRemoteDataSource.execute(request: commentThreadRequest)
      .flatMap { response -> AnyPublisher<[CommentSentimentModel], Error> in
        let commentResponse = response as! [CommentThreadResponse]
        return _sentimentRemoteDataSource.execute(
          request: (commentResponse
            .map { $0.snippet.topLevelComment.snippet.textOriginal } as! SentimentDataSource.Request))
        .map { sentimentResponse in _mapper.transformResponseToEntity(
          request: request,
          commentResponse: response as! [CommentThreadResponse],
          sentimentResponse: sentimentResponse as! [SentimentResponse]) }
        .flatMap { _localeDataSource.add(entities: $0) }
        .filter { $0 }
        .flatMap { _ in _localeDataSource.list(request: request)
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
      }
      .eraseToAnyPublisher()
  }

}
