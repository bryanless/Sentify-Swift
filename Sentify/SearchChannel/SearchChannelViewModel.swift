//
//  SearchChannelViewModel.swift
//  Sentify
//
//  Created by Bryan on 09/05/23.
//

import Foundation

class SearchChannelViewModel: ObservableObject {
  @Published var channelName: String = ""
  @Published var shouldNavigate: Bool = false
}
