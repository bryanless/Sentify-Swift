//
//  GetCommentThreadLocaleDataSource.swift
//  
//
//  Created by Bryan on 10/05/23.
//

import Combine
import Core
import Foundation
import RealmSwift

public struct GetCommentThreadLocaleDataSource: LocaleDataSource {

  public typealias Request = CommentThreadRequest
  public typealias Response = CommentThreadEntity

  private let _realm: Realm

  public init(realm: Realm) {
    _realm = realm
  }

  public func list(request: CommentThreadRequest?) -> AnyPublisher<[CommentThreadEntity], Error> {
    return Future<[CommentThreadEntity], Error> { completion in
      //      guard let request = request else {
      //        return completion(.failure(URLError.invalidRequest))
      //      }

      let comments: Results<CommentThreadEntity> = {
        _realm.objects(CommentThreadEntity.self)
      }()
      completion(.success(comments.toArray(ofType: CommentThreadEntity.self)))
    }.eraseToAnyPublisher()
  }

  public func add(entities: [CommentThreadEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try _realm.write {
          for comment in entities {
            if let commentThreadEntity = _realm.object(
              ofType: CommentThreadEntity.self, forPrimaryKey: comment.id) {
              _realm.add(commentThreadEntity, update: .all)
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

  public func get(id: Int) -> AnyPublisher<CommentThreadEntity, Error> {
    fatalError("Not implemented")
  }

  public func update(id: Int, entity: CommentThreadEntity) -> AnyPublisher<Bool, Error> {
    fatalError("Not implemented")
  }

}
