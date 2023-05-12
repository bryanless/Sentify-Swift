//
//  GetCommentThreadRemoteDataSource.swift
//  
//
//  Created by Bryan on 09/05/23.
//

import Alamofire
import Combine
import Core
import Foundation

public struct GetCommentThreadRemoteDataSource: DataSource {

  public typealias Request = CommentThreadRequest
  public typealias Response = [CommentThreadResponse]

  private let _endpoint: String
  private let _apiKey: String

  public init(
    endpoint: String,
    apiKey: String
  ) {
    _endpoint = endpoint
    _apiKey = apiKey
  }

  public func execute(request: CommentThreadRequest?) -> AnyPublisher<[CommentThreadResponse], Error> {
    return Future<[CommentThreadResponse], Error> { completion in
      guard let request = request else {
        return completion(.failure(URLError.invalidRequest))
      }

      let remoteRequest = CommentThreadRemoteRequest(
        part: request.part,
        videoId: request.videoId,
        order: request.order.name,
        key: _apiKey
      )

      if let url = URL(string: _endpoint) {
        AF.request(
          url,
          parameters: remoteRequest
        )
        .validate()
        .responseDecodable(of: YouTubeDataResponse<CommentThreadResponse>.self) { response in
          switch response.result {
          case .success(let value):
            completion(.success(value.items))
          case .failure(let error):
            if let error = error.underlyingError as? Foundation.URLError, error.code == .notConnectedToInternet {
              completion(.failure(URLError.notConnectedToInternet))
            } else {
              switch error.responseCode {
              case 404:
                completion(.failure(URLError.notFound))
              default:
                completion(.failure(URLError.invalidResponse))
              }
            }
          }
        }
      }
    }
    .eraseToAnyPublisher()
  }

}
