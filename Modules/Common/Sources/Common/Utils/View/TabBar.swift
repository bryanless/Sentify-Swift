//
//  TabBar.swift
//  
//
//  Created by Bryan on 29/12/22.
//

import Core
import SwiftUI

public struct TabBar: View {
  @Binding var selection: Tab

  public init(selection: Binding<Tab>) {
    self._selection = selection
  }

  public var body: some View {
    HStack(alignment: .center) {
      TabItem(
        icon: Icons.search,
        label: "search_title",
        isActive: selection == .search
      ) {
        selection = .search
      }

      TabItem(
        icon: selection == .history ? Icons.user : Icons.userOutlined,
        label: "history_title",
        isActive: selection == .history
      ) {
        selection = .history
      }
    }
    .frame(height: 56.0)
    .padding(
      EdgeInsets(
        top: Space.extraSmall,
        leading: Space.medium,
        bottom: Space.none,
        trailing: Space.medium
      )
    )
    .background(CustomColor.surfaceContainer)
  }
}

public enum Tab {
  case search, history
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
      TabBar(selection: .constant(.search))
    }
}
