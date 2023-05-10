//
//  SentimentAnalysisHistoryView.swift
//  Sentify
//
//  Created by Bryan on 08/05/23.
//

import Common
import SwiftUI

struct SentimentAnalysisHistoryView: View {
  @State var scrollOffset = CGFloat.zero

  var body: some View {
    NavigationBarScrollView(scrollOffset: $scrollOffset) {
      AppBar(
        scrollOffset: scrollOffset,
        label: "aa",
        backgroundColor: .ultraThinMaterial)
    } content: {
      Text("History")
    }
  }
}

struct SentimentAnalysisHistoryView_Previews: PreviewProvider {
  static var previews: some View {
    SentimentAnalysisHistoryView()
  }
}
