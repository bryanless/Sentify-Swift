//
//  SearchChannelView.swift
//  Sentify
//
//  Created by Bryan on 09/05/23.
//

import Common
import SwiftUI

struct SearchChannelView: View {
  @StateObject private var viewModel = SearchChannelViewModel()

  var body: some View {
    VStack {
      Text("What's your channel name?")
        .typography(.title())
      CustomTextField(placeholder: "Your channel name", text: $viewModel.channelName)
      Spacer()
      Button {
        viewModel.shouldNavigate = true
      } label: {
        HStack {
          Spacer()
          Text("Next")
          Spacer()
        }
      }
      .buttonStyle(FilledButton())
    }
    .padding()
    .background {
      NavigationLink(destination: ChannelListView(), isActive: $viewModel.shouldNavigate) {
        EmptyView()
      }
    }
  }
}

struct SearchChannelView_Previews: PreviewProvider {
  static var previews: some View {
    SearchChannelView()
  }
}
