//
//  SentimentEntity.swift
//  
//
//  Created by Bryan on 15/05/23.
//

import Foundation
import RealmSwift

public class SentimentEntity: Object {

  @Persisted(primaryKey: true) var id: UUID = UUID()
  @Persisted var text: String = ""
  @Persisted var tagName: String = ""
  @Persisted var confidence: Double = 0
  @Persisted var createdAt: Date = Date()
  @Persisted var updatedAt: Date = Date()

  public override static func primaryKey() -> String? {
    return "id"
  }

}
