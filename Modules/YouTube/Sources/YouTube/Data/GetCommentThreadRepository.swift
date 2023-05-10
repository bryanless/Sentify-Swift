//
//  GetCommentThreadRepository.swift
//  
//
//  Created by Bryan on 09/05/23.
//

import Combine
import Core

public struct GetCommentThreadRepository<
  CommentThreadLocaleDataSource: LocaleDataSource,
  RemoteDataSource: DataSource,
  Transformer: Mapper>: Repository
where CommentThreadLocaleDataSource.Request == CommentThreadRequest,
      CommentThreadLocaleDataSource.Response == CommentThreadEntity,
      RemoteDataSource.Request == CommentThreadRequest,
      RemoteDataSource.Response == [CommentThreadResponse],
      Transformer.Request == Any,
      Transformer.Response == [CommentThreadResponse],
      Transformer.Entity == [CommentThreadEntity],
      Transformer.Domain == [CommentThreadModel] {

  public typealias Request = CommentThreadRequest
  public typealias Response = [CommentThreadModel]

  private let _localeDataSource: CommentThreadLocaleDataSource
  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer

  public init(
    localeDataSource: CommentThreadLocaleDataSource,
    remoteDataSource: RemoteDataSource,
    mapper: Transformer
  ) {
    _localeDataSource = localeDataSource
    _remoteDataSource = remoteDataSource
    _mapper = mapper
  }

  public func execute(request: CommentThreadRequest?) -> AnyPublisher<[CommentThreadModel], Error> {
    guard let request = request else {
      fatalError("Request cannot be empty")
    }

    return _remoteDataSource.execute(request: request)
      .map { _mapper.transformResponseToEntity(request: request, response: $0) }
      .flatMap { _localeDataSource.add(entities: $0) }
      .filter { $0 }
      .flatMap { _ in _localeDataSource.list(request: request)
          .map { _mapper.transformEntityToDomain(entity: $0) }
          .eraseToAnyPublisher()
      }
      .eraseToAnyPublisher()
  }

}
