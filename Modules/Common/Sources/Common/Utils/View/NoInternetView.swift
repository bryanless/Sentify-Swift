//
//  NoInternetView.swift
//  
//
//  Created by Bryan on 03/02/23.
//

import Core
import SwiftUI

public struct NoInternetView: View {
  let onRetry: () -> Void

  public init(
    onRetry: @escaping () -> Void
  ) {
    self.onRetry = onRetry
  }

  public var body: some View {
    VStack(spacing: Space.large) {
      Image(systemName: Icons.wifiSlash)
        .resizable()
        .scaledToFit()
        .frame(width: 80)
        .foregroundColor(CustomColor.onSurfaceVariant)

      Text("no_internet_label".localized(bundle: .module))
        .typography(.body(color: CustomColor.onSurfaceVariant))

      Button {
        onRetry()
      } label: {
        Text("retry_label".localized(bundle: .module))
          .typography(.body(weight: .bold, color: CustomColor.onPrimary))
      }.buttonStyle(FilledButton())
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(CustomColor.background)
  }
}

struct NoConnectionView_Previews: PreviewProvider {
  static var previews: some View {
    NoInternetView(onRetry: {})
  }
}
