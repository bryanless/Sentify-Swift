//
//  GetCommentSentimentLocaleDataSource.swift
//  Sentify
//
//  Created by Bryan on 16/05/23.
//

import Combine
import Core
import Foundation
import RealmSwift
import YouTube

public struct GetCommentSentimentLocaleDataSource: LocaleDataSource {

  public typealias Request = CommentThreadRequest
  public typealias Response = CommentSentimentEntity

  private let _realm: Realm

  public init(realm: Realm) {
    _realm = realm
  }

  public func list(request: CommentThreadRequest?) -> AnyPublisher<[CommentSentimentEntity], Error> {
    return Future<[CommentSentimentEntity], Error> { completion in
      guard let request = request else {
        return completion(.failure(URLError.invalidRequest))
      }

      let comments: Results<CommentSentimentEntity> = {
        _realm.objects(CommentSentimentEntity.self)
          .where {
            $0.videoId == request.videoId
          }
          .sorted(byKeyPath: request.order.sortKey, ascending: false)
      }()
      completion(.success(comments.toArray(ofType: CommentSentimentEntity.self)))
    }.eraseToAnyPublisher()
  }

  public func add(entities: [CommentSentimentEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try _realm.write {
          for comment in entities {
            if _realm.object(
              ofType: CommentSentimentEntity.self, forPrimaryKey: comment.id) != nil {
              _realm.add(comment, update: .all)
            } else {
              _realm.add(comment)
            }
          }
          completion(.success(true))
        }
      } catch {
        completion(.failure(DatabaseError.requestFailed))
      }
    }
    .eraseToAnyPublisher()
  }

  public func get(id: String) -> AnyPublisher<CommentSentimentEntity, Error> {
    fatalError("Not implemented")
  }

  public func update(id: String, entity: CommentSentimentEntity) -> AnyPublisher<Bool, Error> {
    fatalError("Not implemented")
  }

}
