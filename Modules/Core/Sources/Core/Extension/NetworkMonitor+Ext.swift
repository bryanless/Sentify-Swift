//
//  NetworkMonitor+Ext.swift
//
//
//  Created by Bryan on 02/02/23.
//

import Network

public class NetworkMonitor {
  public static let shared = NetworkMonitor()
  public private(set) var isConnected: Bool = false
  public private(set) var connectionType: ConnectionType = .unknown

  private let queue = DispatchQueue.global(qos: .background)
  private let monitor: NWPathMonitor

  public enum ConnectionType {
    case wifi
    case cellular
    case unknown
  }

  private init() {
    monitor = NWPathMonitor()
  }

  public func startMonitoring() {
    monitor.pathUpdateHandler = { path in
      self.isConnected = path.status != .unsatisfied
      self.getConnectionType(path)
    }

    monitor.start(queue: queue)
  }

  public func stopMonitoring() {
    monitor.cancel()
  }

  private func getConnectionType(_ path: NWPath) {
    if path.usesInterfaceType(.wifi) {
      connectionType = .wifi
    } else if path.usesInterfaceType(.cellular) {
      connectionType = .cellular
    } else {
      connectionType = .unknown
    }
  }
}
