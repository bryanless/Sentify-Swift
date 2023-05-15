//
//  Injection.swift
//  Sentify
//
//  Created by Bryan on 10/05/23.
//

import Core
import Foundation
import RealmSwift
import YouTube

final class Injection: NSObject {

  private var realm: Realm

  init(inMemory: Bool = false) {
    let config: Realm.Configuration

    if inMemory {
      let identifier = "previewRealm"
      config = Realm.Configuration(inMemoryIdentifier: identifier)
    } else {
      config = .defaultConfiguration
    }

    realm = try! Realm(configuration: config)
  }

  func provideCommentThread<R: Repository>() -> R
  where
  R.Request == CommentThreadRequest,
  R.Response == [CommentThreadModel] {
    let locale = GetCommentThreadLocaleDataSource(realm: realm)

    let remote = GetCommentThreadRemoteDataSource(
      endpoint: YouTubeEndpoints.Gets.commentThreads.url,
      apiKey: YouTubeApi.apiKey
    )

    let mapper = CommentThreadTransformer()

    let repository = GetCommentThreadRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)

    return repository as! R
  }

  func provideVideo<R: Repository>() -> R
  where
  R.Request == VideoRequest,
  R.Response == [VideoModel] {
    let locale = GetVideoLocaleDataSource(realm: realm)

    let remote = GetVideoRemoteDataSource(
      endpoint: YouTubeEndpoints.Gets.videos.url,
      apiKey: YouTubeApi.apiKey
    )

    let mapper = VideoTransformer()

    let repository = GetVideoRepository(
      localeDataSource: locale,
      remoteDataSource: remote,
      mapper: mapper)

    return repository as! R
  }
}
