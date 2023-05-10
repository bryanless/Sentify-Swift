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
    ForEach(comments) { comment in
      CommentItem(commentThread: comment)
    }
  }
}

struct CommentListView_Previews: PreviewProvider {
  static var previews: some View {
    CommentListView(comments: [
      CommentThreadModel(id: "", title: "This is a comment")
    ])
  }
}
