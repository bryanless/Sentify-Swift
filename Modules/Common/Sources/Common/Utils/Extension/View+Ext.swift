//
//  View+Ext.swift
//  
//
//  Created by Bryan on 09/05/23.
//

import SwiftUI

extension View {
  public func hideToolbar() -> some View {
    modifier(HiddenToolbarModifier())
  }
}

public struct HiddenToolbarModifier: ViewModifier {
  public func body(content: Content) -> some View {
    if #available(iOS 16, *) {
      content
        .toolbar(.hidden, for: .navigationBar)
    } else {
      content
        .navigationBarHidden(true)
    }
  }
}
