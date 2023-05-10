//
//  ChannelListView.swift
//  Sentify
//
//  Created by Bryan on 09/05/23.
//

import SwiftUI

struct ChannelListView: View {
  var body: some View {
    VStack {
      Text("Channel List")
      Spacer()
    }
    .hideToolbar()
  }
}

struct ChannelListView_Previews: PreviewProvider {
  static var previews: some View {
    ChannelListView()
  }
}
