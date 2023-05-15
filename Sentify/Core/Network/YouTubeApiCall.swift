//
//  YouTubeApiCall.swift
//  Sentify
//
//  Created by Bryan on 09/05/23.
//

import Alamofire

struct YouTubeApi {

  static let baseUrl = "https://www.googleapis.com/youtube/v3/"
  static var apiKey: String {
    guard let apiKey = File.loadDictionaryKey(
      forKey: "YOUTUBE_API_KEY",
      forResource: "Keys",
      ofType: "plist") as? String else {
      fatalError("Value of 'YOUTUBE_API_KEY' in 'Keys.plist' is not a String")
    }

    if apiKey.starts(with: "_") {
      debugPrint("Get an API key at https://developers.google.com/youtube/v3/getting-started#before-you-start.")
    }

    return apiKey
  }

}

enum YouTubeEndpoints {

  enum Gets: Endpoint {
    case search
    case playlistItems
    case videos
    case commentThreads

    public var url: String {
      switch self {
      case .search: return "\(YouTubeApi.baseUrl)search"
      case .playlistItems: return "\(YouTubeApi.baseUrl)playlistItems"
      case .videos: return "\(YouTubeApi.baseUrl)videos"
      case .commentThreads: return "\(YouTubeApi.baseUrl)commentThreads"
      }
    }
  }

}
