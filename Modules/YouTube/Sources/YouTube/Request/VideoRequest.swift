//
//  VideoRequest.swift
//  
//
//  Created by Bryan on 15/05/23.
//

public struct VideoRequest {
  let part: String
  let id: String

  public init(
    part: String = "snippet",
    id: String
  ) {
    self.part = part
    self.id = id
  }
}
