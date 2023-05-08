//
//  TabItem.swift
//  
//
//  Created by Bryan on 29/12/22.
//

import Core
import SwiftUI

public struct TabItem: View {
  let icon: UIImage
  let label: String
  let isActive: Bool
  let onTap: () -> Void

  public var body: some View {
    let color = isActive ? CustomColor.onSurface : CustomColor.onSurfaceVariant
    GeometryReader { geo in
      VStack(alignment: .center, spacing: Space.extraSmall) {
        IconView(icon: icon, color: color)
        Text(label.localized(bundle: .common))
          .typography(.caption(color: color))
      }
      .frame(width: geo.size.width, height: geo.size.height)
      .onTapGesture {
        withAnimation(.easeIn(duration: 0.1)) {
          onTap()
        }
      }
    }
  }
}

struct TabItem_Previews: PreviewProvider {
  static var previews: some View {
    TabItem(icon: Icons.houseOutlined, label: "Home", isActive: true) {}
  }
}
