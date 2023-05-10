//
//  VideoRemoteRequest.swift
//  
//
//  Created by Bryan on 09/05/23.
//

import Foundation

public struct VideoRemoteRequest: Encodable {
  let part: String
  let id: String?
  let key: String

  public init(
    part: String = "snippet",
    id: String?,
    key: String
  ) {
    self.part = part
    self.id = id
    self.key = key
  }
}
