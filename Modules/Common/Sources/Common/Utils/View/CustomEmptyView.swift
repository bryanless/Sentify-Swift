//
//  CustomEmptyView.swift
//  
//
//  Created by Bryan on 30/12/22.
//

import Core
import SwiftUI

public struct CustomEmptyView: View {
  let image: UIImage?
  let icon: String?
  let label: String
  let imageWidth: CGFloat?

  public init(
    image: UIImage? = nil,
    icon: String? = nil,
    label: String,
    imageWidth: CGFloat? = nil
  ) {
    self.image = image
    self.icon = icon
    self.label = label
    self.imageWidth = imageWidth
  }

  public var body: some View {
    VStack(spacing: Space.large) {
      if image != nil {
        Image(uiImage: image!)
          .resizable()
          .scaledToFit()
          .frame(width: imageWidth ?? 240)
          .foregroundColor(CustomColor.onSurfaceVariant)
      }

      if icon != nil {
        Image(systemName: icon!)
          .resizable()
          .scaledToFit()
          .frame(width: imageWidth ?? 80)
          .foregroundColor(CustomColor.onSurfaceVariant)
      }

      Text(label)
        .typography(.body(color: CustomColor.onSurfaceVariant))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(CustomColor.background)
  }
}

struct CustomEmptyView_Previews: PreviewProvider {
  static var previews: some View {
    CustomEmptyView(label: "No anime found")
  }
}
