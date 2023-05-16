//
//  GetSentimentLocaleDataSource.swift
//  
//
//  Created by Bryan on 15/05/23.
//

import Combine
import Core
import Foundation
import RealmSwift

public struct GetSentimentLocaleDataSource: LocaleDataSource {

  public typealias Request = [String]
  public typealias Response = SentimentEntity

  private let _realm: Realm

  public init(realm: Realm) {
    _realm = realm
  }

  public func list(request: [String]?) -> AnyPublisher<[SentimentEntity], Error> {
    return Future<[SentimentEntity], Error> { completion in
//      guard let request = request else {
//        return completion(.failure(URLError.invalidRequest))
//      }

      let sentiments: Results<SentimentEntity> = {
        _realm.objects(SentimentEntity.self)
          .sorted(byKeyPath: "createdAt")
      }()
      completion(.success(sentiments.toArray(ofType: SentimentEntity.self)))
    }.eraseToAnyPublisher()
  }

  public func add(entities: [SentimentEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try _realm.write {
          for sentiment in entities {
            if let sentimentEntity = _realm.object(
              ofType: SentimentEntity.self, forPrimaryKey: sentiment.id) {
              _realm.add(sentimentEntity, update: .all)
            } else {
              _realm.add(sentiment)
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

  public func get(id: String) -> AnyPublisher<SentimentEntity, Error> {
    fatalError("Not implemented")
  }

  public func update(id: String, entity: SentimentEntity) -> AnyPublisher<Bool, Error> {
    fatalError("Not implemented")
  }

}
