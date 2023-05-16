//
//  CommentItem.swift
//  Sentify
//
//  Created by Bryan on 10/05/23.
//

import Common
import Core
import MonkeyLearn
import SwiftUI
import SDWebImageSwiftUI
import YouTube

struct CommentItem: View {
  let commentThread: CommentSentimentModel

  var body: some View {
    HStack(alignment: .top, spacing: Space.medium) {
      WebImage(url: URL(string: commentThread.authorProfileImageUrl))
        .resizable()
        .placeholder {
          ImagePlaceholder()
        }
        .indicator(.activity)
        .transition(.fade(duration: 0.5))
        .scaledToFill()
        .frame(width: 44, height: 44)
        .cornerRadius(RoundedShape.full)

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
    Text(commentThread.authorDisplayName)
      .typography(.caption2(color: CustomColor.onSurfaceVariant))
  }

  var content: some View {
    Text(commentThread.title)
      .typography(.subheadline())
  }

  var tags: some View {
    var foregroundColor: Color
    var background: Color

    if commentThread.tagName == SentimentTagName.positive.value {
      foregroundColor = CustomColor.onPrimaryContainer
      background = CustomColor.primaryContainer
    } else if commentThread.tagName == SentimentTagName.negative.value {
      foregroundColor = CustomColor.onTertiaryContainer
      background = CustomColor.tertiaryContainer
    } else {
      foregroundColor = CustomColor.onSurface
      background = CustomColor.surfaceVariant
    }

    return HStack {
      Chip(
        label: commentThread.tagName,
        foregroundColor: foregroundColor,
        background: background,
        cornerRadius: RoundedShape.full)
    }
  }
}

struct CommentItem_Previews: PreviewProvider {
  static var previews: some View {
    CommentItem(
      commentThread: CommentSentimentModel(
        id: "id",
        videoId: "videoId",
        title: "This a short, one sentence comment which is commonly seen in the comment section.",
      authorDisplayName: "Author Name",
      authorProfileImageUrl: "",
      tagName: "positive",
      confidence: "0"))
  }
}
