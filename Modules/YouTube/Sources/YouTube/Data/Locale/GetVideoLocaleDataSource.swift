//
//  GetVideoLocaleDataSource.swift
//  
//
//  Created by Bryan on 15/05/23.
//

import Combine
import Core
import Foundation
import RealmSwift

public struct GetVideoLocaleDataSource: LocaleDataSource {

  public typealias Request = VideoRequest
  public typealias Response = VideoEntity

  private let _realm: Realm

  public init(realm: Realm) {
    _realm = realm
  }

  public func list(request: VideoRequest?) -> AnyPublisher<[VideoEntity], Error> {
    fatalError("Not implemented")
  }

  public func add(entities: [VideoEntity]) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      do {
        try _realm.write {
          for video in entities {
            if let videoEntity = _realm.object(
              ofType: VideoEntity.self, forPrimaryKey: video.id) {
              _realm.add(videoEntity, update: .all)
            } else {
              _realm.add(video)
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

  public func get(id: String) -> AnyPublisher<VideoEntity, Error> {
    return Future<VideoEntity, Error> { completion in
      if let videoEntity = _realm.object(ofType: VideoEntity.self, forPrimaryKey: id) {
        completion(.success(videoEntity))
      } else {
        completion(.failure(DatabaseError.requestFailed))
      }
    }.eraseToAnyPublisher()
  }

  public func update(id: String, entity: VideoEntity) -> AnyPublisher<Bool, Error> {
    fatalError("Not implemented")
  }

}
