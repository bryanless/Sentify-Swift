//
//  CustomError+Ext.swift
//  
//
//  Created by Bryan on 06/01/23.
//

import Foundation

public enum URLError: LocalizedError {

  case invalidRequest
  case invalidResponse
  case notFound
  case addressUnreachable(URL)
  case notConnectedToInternet

  public var errorDescription: String? {
    switch self {
    case .invalidRequest: return "Request is null."
    case .invalidResponse: return "The server responded with garbage."
    case .notFound: return "Not found"
    case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
    case .notConnectedToInternet: return "No internet connection"
    }
  }

}

public enum DatabaseError: LocalizedError {

  case invalidInstance
  case requestFailed

  public var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    }
  }
}
