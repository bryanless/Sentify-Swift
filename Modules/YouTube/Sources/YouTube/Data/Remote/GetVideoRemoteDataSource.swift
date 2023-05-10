//
//  GetVideoRemoteDataSource.swift
//  
//
//  Created by Bryan on 09/05/23.
//

import Alamofire
import Combine
import Core
import Foundation

public struct GetVideoRemoteDataSource: DataSource {

  public typealias Request = VideoRemoteRequest
  public typealias Response = [VideoResponse]

  private let _endpoint: String
  private let _apiKey: String

  public init(
    endpoint: String,
    apiKey: String
  ) {
    _endpoint = endpoint
    _apiKey = apiKey
  }

  public func execute(request: VideoRemoteRequest?) -> AnyPublisher<[VideoResponse], Error> {
    return Future<[VideoResponse], Error> { completion in
      guard let request = request else {
        return completion(.failure(URLError.invalidRequest))
      }

      let remoteRequest = VideoRemoteRequest(
        part: request.part,
        id: request.id,
        key: _apiKey
      )

      if let url = URL(string: _endpoint) {
        AF.request(
          url,
          parameters: remoteRequest
        )
        .validate()
        .responseDecodable(of: YouTubeDataResponse<VideoResponse>.self) { response in
          switch response.result {
          case .success(let value):
            completion(.success(value.items))
          case .failure(let error):
            if let error = error.underlyingError as? Foundation.URLError, error.code == .notConnectedToInternet {
              // No internet connection
              completion(.failure(URLError.notConnectedToInternet))
            } else {
              completion(.failure(URLError.invalidResponse))
            }
          }
        }
      }
    }
    .eraseToAnyPublisher()
  }

}
