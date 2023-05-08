//
//  SearchBar.swift
//  
//
//  Created by Bryan on 30/12/22.
//

import Core
import SwiftUI

public struct SearchBar: View {
  let placeholder: String
  @Binding var searchText: String

  public init(
    placeholder: String,
    searchText: Binding<String>
  ) {
    self.placeholder = placeholder
    self._searchText = searchText
  }

  public var body: some View {
    HStack {
      IconView(
        icon: Icons.search,
        color: searchText.isEmpty ? CustomColor.onSurfaceVariant : CustomColor.onSurface,
        size: IconSize.small
      )

      ZStack(alignment: .leading) {
        if searchText.isEmpty {
          Text(placeholder)
            .typography(
              .body(
                color: CustomColor.onSurfaceVariant
              )
            )
        }
        TextField("", text: $searchText)
          .typography(
            .body(
              color: searchText.isEmpty ? CustomColor.onSurfaceVariant : CustomColor.onSurface
            )
          )
          .tint(CustomColor.primary)
          .autocorrectionDisabled(true)
      }
    }
    .padding(
      EdgeInsets(
        top: Space.small,
        leading: Space.medium,
        bottom: Space.small,
        trailing: Space.medium)
    )
    .background(CustomColor.surfaceVariant)
    .cornerRadius(RoundedShape.small)
  }
}

struct SearchBar_Previews: PreviewProvider {
  static var previews: some View {
    SearchBar(placeholder: "Search anime", searchText: .constant(""))
  }
}
