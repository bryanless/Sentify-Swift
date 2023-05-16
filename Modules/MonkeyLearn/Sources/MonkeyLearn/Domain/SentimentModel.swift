//
//  SentimentModel.swift
//  
//
//  Created by Bryan on 15/05/23.
//

import Foundation
import RealmSwift

public struct SentimentModel: Equatable, Identifiable {
  public let id: UUID
  public let text: String
  public let tagName: String
  public let confidence: String

  public init(id: UUID, text: String, tagName: String, confidence: String) {
    self.id = id
    self.text = text
    self.tagName = tagName
    self.confidence = confidence
  }
}
