//
//  SentimentRemoteRequest.swift
//  
//
//  Created by Bryan on 15/05/23.
//

public struct SentimentRemoteRequest: Encodable {
  let data: [String]

  public init(data: [String]) {
    self.data = data
  }
}
