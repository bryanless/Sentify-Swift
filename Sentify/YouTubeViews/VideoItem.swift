//
//  VideoItem.swift
//  Sentify
//
//  Created by Bryan on 15/05/23.
//

import Common
import Core
import SwiftUI
import SDWebImageSwiftUI
import YouTube

struct VideoItem: View {
  let video: VideoModel

  var body: some View {
    HStack(alignment: .top, spacing: Space.medium) {
      VStack(alignment: .leading, spacing: Space.small) {
        content
        footer
      }
      .padding(.vertical, Space.extraSmall)

      Spacer(minLength: Space.small)

      WebImage(url: URL(string: video.thumbnailsMedium))
        .resizable()
        .placeholder {
          ImagePlaceholder()
        }
        .indicator(.activity)
        .transition(.fade(duration: 0.5))
        .aspectRatio(16/9, contentMode: .fit)
        .frame(height: 70)
        .cornerRadius(RoundedShape.small)
    }
  }
}

extension VideoItem {
  var content: some View {
    if #available(iOS 16, *) {
      return Text(video.title)
        .typography(.subheadline(weight: .bold))
        .lineLimit(2, reservesSpace: true)
    } else {
      return Text(video.title)
        .typography(.subheadline(weight: .bold))
        .lineLimit(2)
    }
  }

  var footer: some View {
    Text("By \(video.channelTitle)")
      .typography(.caption2(color: CustomColor.onSurfaceVariant))
      .lineLimit(1)
  }
}

struct VideoItem_Previews: PreviewProvider {
  static var previews: some View {
    CommentItem(
      commentThread: CommentThreadModel(
        id: "id",
        videoId: "videoId",
        title: "This a short, one sentence comment which is commonly seen in the comment section.",
      authorDisplayName: "Author Name",
      authorProfileImageUrl: ""))
  }
}
