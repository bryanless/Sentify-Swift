//
//  ImagePlaceholder.swift
//  
//
//  Created by Bryan on 04/02/23.
//

import Core
import SwiftUI

public struct ImagePlaceholder: View {

  public init() {}

  public var body: some View {
    VStack {
      IconView(
        icon: Icons.imageOutlined,
        color: CustomColor.onSurfaceVariant)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(CustomColor.surfaceVariant)
  }
}

struct ImagePlaceholder_Previews: PreviewProvider {
  static var previews: some View {
    ImagePlaceholder()
  }
}
