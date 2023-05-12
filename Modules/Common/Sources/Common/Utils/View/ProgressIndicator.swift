//
//  ProgressIndicator.swift
//  
//
//  Created by Bryan on 30/12/22.
//

import Core
import SwiftUI

public struct ProgressIndicator: View {
  private let _label: String

  public init(
    label: String = "loading_label"
  ) {
    _label = label
  }

  public var body: some View {
    VStack(spacing: Space.medium) {
      ProgressView()
        .tint(CustomColor.onSurfaceVariant)
      Text(_label.localized(bundle: .module))
        .typography(.body(color: CustomColor.onSurfaceVariant))
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}

struct ProgressIndicator_Previews: PreviewProvider {
  static var previews: some View {
    ProgressIndicator(label: "Searching item")
  }
}
