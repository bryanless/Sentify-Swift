//
//  Button.swift
//  
//
//  Created by Bryan on 03/02/23.
//

import Core
import SwiftUI

public struct FilledButton<S: ShapeStyle>: ButtonStyle {
  @State private var pressed = false
  let foregroundColor: Color
  let background: S

  public init(
    foregroundColor: Color = CustomColor.onPrimary,
    background: S = CustomColor.primary
  ) {
    self.foregroundColor = foregroundColor
    self.background = background
  }

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(
        EdgeInsets(
          top: Space.small,
          leading: Space.large,
          bottom: Space.small,
          trailing: Space.large)
      )
      .foregroundColor(foregroundColor)
      .background(background)
      .compositingGroup()
      .opacity(configuration.isPressed ? 0.5 : 1.0)
      .clipShape(Capsule())
  }
}
