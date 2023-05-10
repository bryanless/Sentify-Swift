//
//  CommentListView.swift
//  Sentify
//
//  Created by Bryan on 09/05/23.
//

import SwiftUI
import YouTube

struct CommentListView: View {
  let comments: [CommentThreadModel]

  var body: some View {
    List(comments) { comment in
      Text(comment.title)
    }
  }
}

struct CommentListView_Previews: PreviewProvider {
  static var previews: some View {
    CommentListView(comments: [])
  }
}
