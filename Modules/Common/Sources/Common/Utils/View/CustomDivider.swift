//
//  CustomDivider.swift
//  
//
//  Created by Bryan on 30/12/22.
//

import Core
import SwiftUI

public struct CustomDivider: View {

  public init() {}

  public var body: some View {
    Divider()
      .overlay(CustomColor.outlineVariant)
  }
}

struct CustomDivider_Previews: PreviewProvider {
  static var previews: some View {
    CustomDivider()
  }
}
