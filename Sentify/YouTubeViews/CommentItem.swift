//
//  CommentItem.swift
//  Sentify
//
//  Created by Bryan on 10/05/23.
//

import Common
import Core
import SwiftUI
import YouTube

struct CommentItem: View {
  let commentThread: CommentThreadModel

  var body: some View {
    HStack(alignment: .top, spacing: Space.medium) {
      IconView(icon: Icons.userCircle, size: 44)

      VStack(alignment: .leading, spacing: Space.small) {
        header
        content
        tags
      }
      .padding(.vertical, Space.extraSmall)

      Spacer()
    }
  }
}

extension CommentItem {
  var header: some View {
    Text("Author Name")
      .typography(.caption2(color: CustomColor.onSurfaceVariant))
  }

  var content: some View {
    Text(commentThread.title)
      .typography(.subheadline())
  }

  var tags: some View {
    HStack {
      Chip(label: "Positive", cornerRadius: RoundedShape.full)
    }
  }
}

struct CommentItem_Previews: PreviewProvider {
  static var previews: some View {
    CommentItem(
      commentThread: CommentThreadModel(
        id: "id",
        title: "This a short, one sentence comment which is commonly seen in the comment section."))
  }
}
