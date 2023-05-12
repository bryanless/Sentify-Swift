//
//  SearchField.swift
//  
//
//  Created by Bryan on 08/05/23.
//

import Core
import SwiftUI

public struct SearchField: View {
  @FocusState private var isFocused: Bool
  @State private var shouldShowCancel: Bool = false
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
            .focused($isFocused)
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

      if shouldShowCancel {
        Button("Cancel", role: .cancel) {
          isFocused = false
        }
        .foregroundColor(CustomColor.onSurfaceVariant)
      }
    }
    .onChange(of: isFocused) { value in
      shouldShowCancel = value
    }
    .animation(.easeInOut(duration: 0.2), value: shouldShowCancel)
  }
}

public struct SearchField_Previews: PreviewProvider {
  public static var previews: some View {
    SearchField(
      placeholder: "Search item",
      searchText: .constant(""))
  }
}
