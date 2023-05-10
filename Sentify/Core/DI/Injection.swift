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

  private let realm = try? Realm()

  func provideCommentThread<R: Repository>() -> R
  where
  R.Request == CommentThreadRequest,
  R.Response == [CommentThreadModel] {
    let locale = GetCommentThreadLocaleDataSource(realm: realm!)

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
}
