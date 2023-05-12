//
//  NavigationBarScrollView.swift
//  
//
//  Created by Bryan on 08/05/23.
//

import Core
import SwiftUI

public struct NavigationBarScrollView<S: ShapeStyle, NavigationBar: View, Content: View>: View {
  @Binding var scrollOffset: CGFloat
  @Binding var isRefreshing: Bool
  let refreshLabel: String
  let onRefresh: (() -> Void)?
  let showsIndicators: Bool
  let background: S
  let navigationBar: (() -> NavigationBar)?
  let content: () -> Content

  public init(
    scrollOffset: Binding<CGFloat>,
    showsIndicators: Bool = true,
    background: S = CustomColor.background,
    @ViewBuilder content: @escaping () -> Content
  ) {
    _scrollOffset = scrollOffset
    self.showsIndicators = showsIndicators
    self.refreshLabel = ""
    _isRefreshing = .constant(false)
    self.onRefresh = nil
    self.background = background
    self.navigationBar = nil
    self.content = content
  }

  public init(
    scrollOffset: Binding<CGFloat>,
    showsIndicators: Bool = true,
    background: S = CustomColor.background,
    @ViewBuilder navigationBar: @escaping () -> NavigationBar = { EmptyView() },
    @ViewBuilder content: @escaping () -> Content
  ) {
    _scrollOffset = scrollOffset
    self.showsIndicators = showsIndicators
    self.refreshLabel = ""
    _isRefreshing = .constant(false)
    self.onRefresh = nil
    self.background = background
    self.navigationBar = navigationBar
    self.content = content
  }

  public init(
    scrollOffset: Binding<CGFloat>,
    showsIndicators: Bool = true,
    refreshLabel: String = "",
    isRefreshing: Binding<Bool>,
    onRefresh: (() -> Void)?,
    background: S = CustomColor.background,
    @ViewBuilder navigationBar: @escaping () -> NavigationBar = { EmptyView() },
    @ViewBuilder content: @escaping () -> Content
  ) {
    _scrollOffset = scrollOffset
    self.showsIndicators = showsIndicators
    self.refreshLabel = refreshLabel
    _isRefreshing = isRefreshing
    self.onRefresh = onRefresh
    self.background = background
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
        if navigationBar != nil {
          navigationBar!()
        }
      }
      .background(background)
    } else {
      ObservableScrollView(
        scrollOffset: $scrollOffset,
        showsIndicators: showsIndicators,
        content: content
      )
      .safeAreaInset(edge: .top) {
        if navigationBar != nil {
          navigationBar!()
        }
      }
      .onAppear {
        UIRefreshControl.appearance().tintColor = UIColor(CustomColor.onSurfaceVariant)
        UIRefreshControl.appearance().attributedTitle = NSAttributedString(string: refreshLabel)
      }
      .refreshable {
        onRefresh!()
        await refreshing()
      }
      .background(background)
    }
  }
}

extension NavigationBarScrollView {
  func refreshing() async {
    while isRefreshing {}
  }
}
