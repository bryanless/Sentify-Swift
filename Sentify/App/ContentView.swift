//
//  ContentView.swift
//  Sentify
//
//  Created by Bryan on 08/05/23.
//

import Core
import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundColor(.accentColor)
      Text("Hello, world!")
        .typography(.body(color: CustomColor.onBackground))
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}