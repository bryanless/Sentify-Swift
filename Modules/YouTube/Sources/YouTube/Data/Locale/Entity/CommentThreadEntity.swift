//
//  CommentThreadEntity.swift
//  
//
//  Created by Bryan on 10/05/23.
//

import Foundation
import RealmSwift

public class CommentThreadEntity: Object {

  @Persisted(primaryKey: true) var id: String = ""
  @Persisted var title: String = ""
  @Persisted var createdAt: Date = Date()
  @Persisted var updatedAt: Date = Date()

  public override static func primaryKey() -> String? {
    return "id"
  }

}
