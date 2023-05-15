//
//  GetVideoRepository.swift
//  
//
//  Created by Bryan on 15/05/23.
//

import Combine
import Core

public struct GetVideoRepository<
  VideoLocaleDataSource: LocaleDataSource,
  RemoteDataSource: DataSource,
  Transformer: Mapper>: Repository
where VideoLocaleDataSource.Request == VideoRequest,
      VideoLocaleDataSource.Response == VideoEntity,
      RemoteDataSource.Request == VideoRequest,
      RemoteDataSource.Response == [VideoResponse],
      Transformer.Request == Any,
      Transformer.Response == [VideoResponse],
      Transformer.Entity == [VideoEntity],
      Transformer.Domain == [VideoModel] {

  public typealias Request = VideoRequest
  public typealias Response = [VideoModel]

  private let _localeDataSource: VideoLocaleDataSource
  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer

  public init(
    localeDataSource: VideoLocaleDataSource,
    remoteDataSource: RemoteDataSource,
    mapper: Transformer
  ) {
    _localeDataSource = localeDataSource
    _remoteDataSource = remoteDataSource
    _mapper = mapper
  }

  public func execute(request: VideoRequest?) -> AnyPublisher<[VideoModel], Error> {
    guard let request = request else {
      fatalError("Request cannot be empty")
    }

    return _remoteDataSource.execute(request: request)
      .map { _mapper.transformResponseToEntity(request: request, response: $0) }
      .flatMap { _localeDataSource.add(entities: $0) }
      .filter { $0 }
      .flatMap { _ in _localeDataSource.get(id: request.id)
          .map { _mapper.transformEntityToDomain(entity: [$0]) }
          .eraseToAnyPublisher()
      }
      .eraseToAnyPublisher()
  }

}
