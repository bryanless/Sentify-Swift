//
//  VideoEntity.swift
//  
//
//  Created by Bryan on 12/05/23.
//

import Foundation
import RealmSwift

public class VideoEntity: Object {

  @Persisted(primaryKey: true) var id: String = ""
  @Persisted var channelTitle: String = ""
  @Persisted var title: String = ""
  @Persisted var thumbnailsMedium: String = ""
  @Persisted var createdAt: Date = Date()
  @Persisted var updatedAt: Date = Date()

  public override static func primaryKey() -> String? {
    return "id"
  }

}
