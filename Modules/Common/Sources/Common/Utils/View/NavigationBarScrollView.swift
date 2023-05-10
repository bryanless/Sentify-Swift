//
//  NavigationBarScrollView.swift
//  
//
//  Created by Bryan on 08/05/23.
//

import Core
import SwiftUI

public struct NavigationBarScrollView<NavigationBar: View, Content: View>: View {
  @Binding var scrollOffset: CGFloat
  @Binding var isRefreshing: Bool
  let refreshLabel: String
  let onRefresh: (() -> Void)?
  let showsIndicators: Bool
  let navigationBar: () -> NavigationBar
  let content: () -> Content

  public init(
    scrollOffset: Binding<CGFloat>,
    showsIndicators: Bool = true,
    refreshLabel: String = "",
    @ViewBuilder navigationBar: @escaping () -> NavigationBar = { EmptyView() },
    @ViewBuilder content: @escaping () -> Content
  ) {
    _scrollOffset = scrollOffset
    self.showsIndicators = showsIndicators
    self.refreshLabel = refreshLabel
    _isRefreshing = .constant(false)
    self.onRefresh = nil
    self.navigationBar = navigationBar
    self.content = content
  }

  public init(
    scrollOffset: Binding<CGFloat>,
    showsIndicators: Bool = true,
    refreshLabel: String = "",
    isRefreshing: Binding<Bool>,
    onRefresh: (() -> Void)?,
    @ViewBuilder navigationBar: @escaping () -> NavigationBar = { EmptyView() },
    @ViewBuilder content: @escaping () -> Content
  ) {
    _scrollOffset = scrollOffset
    self.showsIndicators = showsIndicators
    self.refreshLabel = refreshLabel
    _isRefreshing = isRefreshing
    self.onRefresh = onRefresh
    self.navigationBar = navigationBar
    self.content = content
  }

  public var body: some View {
    if onRefresh == nil {
      ObservableScrollView(
        scrollOffset: $scrollOffset,
        showsIndicators: showsIndicators,
        content: content
      )
      .safeAreaInset(edge: .top) {
        navigationBar()
      }
    } else {
      ObservableScrollView(
        scrollOffset: $scrollOffset,
        showsIndicators: showsIndicators,
        content: content
      )
      .safeAreaInset(edge: .top) {
        navigationBar()
      }
      .onAppear {
        UIRefreshControl.appearance().tintColor = UIColor(CustomColor.onSurfaceVariant)
        UIRefreshControl.appearance().attributedTitle = NSAttributedString(string: refreshLabel)
      }
      .refreshable {
        onRefresh!()
        await refreshing()
      }
    }
  }
}

extension NavigationBarScrollView {
  func refreshing() async {
    while isRefreshing {}
  }
}
