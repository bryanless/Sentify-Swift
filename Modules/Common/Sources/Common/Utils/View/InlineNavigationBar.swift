//
//  InlineNavigationBar.swift
//  
//
//  Created by Bryan on 30/12/22.
//

import Core
import SwiftUI

public struct InlineNavigationBar<S: ShapeStyle, Content: View>: View {
  var scrollOffset: CGFloat
  let label: String
  let alwaysShowLabel: Bool
  let backgroundColor: S
  let leading: () -> Content?
  let trailing: () -> Content?

  public init(
    scrollOffset: CGFloat,
    label: String,
    alwaysShowLabel: Bool = false,
    backgroundColor: S = CustomColor.surfaceContainer,
    @ViewBuilder leading: @escaping () -> Content? = { Text("") },
    @ViewBuilder trailing: @escaping () -> Content? = { Text("") }
  ) {
    self.scrollOffset = scrollOffset
    self.label = label
    self.alwaysShowLabel = alwaysShowLabel
    self.backgroundColor = backgroundColor
    self.leading = leading
    self.trailing = trailing
  }

  public var body: some View {
    VStack(spacing: Space.small) {
      HStack(spacing: Space.small) {
        leading()
          .frame(alignment: .leading)
        Text(label)
          .typography(.title3(weight: .bold, color: .black))
          .lineLimit(1)
          .opacity(alwaysShowLabel ? 1 : scrollOffset / 100)
          .frame(alignment: .center)
        trailing()
          .frame(alignment: .trailing)
      }
    }
    .padding(
      EdgeInsets(
        top: Space.none,
        leading: Space.medium,
        bottom: Space.small,
        trailing: Space.medium)
    )
    .frame(maxWidth: .infinity)
    .background(backgroundColor.opacity(scrollOffset / 100))
  }
}

public struct BackAppBar<Content: View>: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  var scrollOffset: CGFloat
  let label: String
  let alwaysShowLabel: Bool
  let trailing: () -> Content?

  public init(
    scrollOffset: CGFloat,
    label: String,
    alwaysShowLabel: Bool = false,
    @ViewBuilder trailing: @escaping () -> Content? = { Text("") }
  ) {
    self.scrollOffset = scrollOffset
    self.label = label
    self.alwaysShowLabel = alwaysShowLabel
    self.trailing = trailing
  }

  public var body: some View {
    GeometryReader { geo in
      VStack(spacing: Space.small) {
        HStack(spacing: Space.small) {
          Button {
            presentationMode.wrappedValue.dismiss()
          } label: {
            IconView(icon: Icons.caretLeft)
          }.frame(maxWidth: geo.size.width / 4, alignment: .leading)
          Text(label)
            .typography(.title3(weight: .bold, color: .black))
            .lineLimit(1)
            .opacity(alwaysShowLabel ? 1 : scrollOffset / 100)
            .frame(maxWidth: geo.size.width / 2, alignment: .center)
          trailing()
            .frame(maxWidth: geo.size.width / 4, alignment: .trailing)
        }
      }
      .padding(
        EdgeInsets(
          top: Space.none,
          leading: Space.medium,
          bottom: Space.small,
          trailing: Space.medium)
      )
      .frame(width: geo.size.width)
      .background(scrollOffset > 1 ? CustomColor.surfaceContainer : Color.black.opacity(0))
    }
  }
}

struct AppBar_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      InlineNavigationBar(scrollOffset: 500, label: "Title")
        .previewDisplayName("App Bar")

      BackAppBar(scrollOffset: 500, label: "Title")
        .previewDisplayName("App Bar with Back")
    }
  }
}
