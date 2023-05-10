//
//  Chip.swift
//  
//
//  Created by Bryan on 10/05/23.
//

import Core
import SwiftUI

public struct Chip<S: ShapeStyle>: View {
  let label: String
  let foregroundColor: Color
  let background: S
  let cornerRadius: CGFloat

  public init(
    label: String,
    foregroundColor: Color = CustomColor.onSecondaryContainer,
    background: S = CustomColor.secondaryContainer,
    cornerRadius: CGFloat = RoundedShape.small
  ) {
    self.label = label
    self.foregroundColor = foregroundColor
    self.background = background
    self.cornerRadius = cornerRadius
  }

  public var body: some View {
    Text(label)
      .typography(.caption(color: foregroundColor))
      .padding(
        EdgeInsets(
          top: Space.extraSmall,
          leading: Space.large,
          bottom: Space.extraSmall,
          trailing: Space.large)
      )
      .frame(height: 32.0)
      .background(background)
      .cornerRadius(cornerRadius)
  }
}

public struct Chip_Previews: PreviewProvider {
  public static var previews: some View {
    Chip(
      label: "Chip",
      foregroundColor: .black,
      background: .teal
    )
  }
}
