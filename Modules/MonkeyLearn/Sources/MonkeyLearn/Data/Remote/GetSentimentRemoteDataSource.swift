//
//  GetSentimentRemoteDataSource.swift
//  
//
//  Created by Bryan on 15/05/23.
//

import Alamofire
import Combine
import Core
import Foundation

public struct GetSentimentRemoteDataSource: DataSource {

  public typealias Request = [String]
  public typealias Response = [SentimentResponse]

  private let _endpoint: String
  private let _headers: HTTPHeaders

  public init(
    endpoint: String,
    headers: HTTPHeaders
  ) {
    _endpoint = endpoint
    _headers = headers
  }

  public func execute(request: [String]?) -> AnyPublisher<[SentimentResponse], Error> {
    return Future<[SentimentResponse], Error> { completion in
      guard let request = request else {
        return completion(.failure(URLError.invalidRequest))
      }

      let remoteRequest = SentimentRemoteRequest(data: request)

      if let url = URL(string: _endpoint) {
        AF.request(
          url,
          method: .post,
          parameters: remoteRequest,
          encoder: .json,
          headers: _headers
        )
        .validate()
        .responseDecodable(of: [SentimentResponse].self) { response in
          switch response.result {
          case .success(let value):
            completion(.success(value))
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
