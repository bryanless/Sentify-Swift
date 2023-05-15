//
//  MonkeyLearnApiCall.swift
//  Sentify
//
//  Created by Bryan on 15/05/23.
//

import Alamofire

struct MonkeyLearnApi {

  static let baseUrl = "https://api.monkeylearn.com/v3/"
  static var headers: HTTPHeaders {
    guard let apiKey = File.loadDictionaryKey(
      forKey: "MONKEYLEARN_API_KEY",
      forResource: "Keys",
      ofType: "plist") as? String else {
      fatalError("Value of 'MONKEYLEARN_API_KEY' in 'Keys.plist' is not a String")
    }

    if apiKey.starts(with: "_") {
      debugPrint("Create a MyAnimeList account and get a Client ID (API key) at https://myanimelist.net/apiconfig.")
    }

    return ["Authorization": "Token \(apiKey)"]
  }

}

enum MonkeyLearnEndpoints {

  enum Gets: Endpoint {
    case sentimentAnalysis

    public var url: String {
      switch self {
      case .sentimentAnalysis: return "\(MonkeyLearnApi.baseUrl)classifiers/cl_NDBChtr7/classify/"
      }
    }
  }

}
