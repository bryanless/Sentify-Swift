//
//  CustomNavigationView.swift
//  
//
//  Created by Bryan on 08/05/23.
//

import SwiftUI

public struct CustomNavigationView<Content: View>: View {
  let content: () -> Content

  public init(content: @escaping () -> Content) {
    self.content = content
  }

  public var body: some View {
    if #available(iOS 16, *) {
      NavigationStack {
        content()
          .toolbar(.hidden, for: .navigationBar)
      }
    } else {
      NavigationView {
        content()
          .navigationBarHidden(true)
      }
      .navigationViewStyle(.stack)
    }
  }
}
