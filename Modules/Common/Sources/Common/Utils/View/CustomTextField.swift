//
//  CustomTextField.swift
//  
//
//  Created by Bryan on 09/05/23.
//

import Core
import SwiftUI

public struct CustomTextField: View {
  let placeholder: String
  @Binding var text: String
  let leadingIcon: UIImage?

  public init(
    placeholder: String,
    text: Binding<String>,
    leadingIcon: UIImage? = nil
  ) {
    self.placeholder = placeholder
    self._text = text
    self.leadingIcon = leadingIcon
  }

  public var body: some View {
    HStack {
      if leadingIcon != nil {
        IconView(
          icon: leadingIcon!,
          color: text.isEmpty ? CustomColor.onSurfaceVariant : CustomColor.onSurface,
          size: IconSize.small
        )
      }

      ZStack(alignment: .leading) {
        if text.isEmpty {
          Text(placeholder)
            .typography(
              .body(
                color: CustomColor.onSurfaceVariant
              )
            )
        }
        TextField("", text: $text)
          .typography(
            .body(
              color: text.isEmpty ? CustomColor.onSurfaceVariant : CustomColor.onSurface
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

public struct CustomTextField_Previews: PreviewProvider {
  public static var previews: some View {
    CustomTextField(placeholder: "Placeholder", text: .constant("Text"))
  }
}
