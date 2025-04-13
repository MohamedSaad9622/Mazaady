//
//  NetworkMonitor.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 13/04/2025.
//

import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private(set) var isConnected: Bool = false
    private(set) var connectionType: NWInterface.InterfaceType?

    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.connectionType = path.availableInterfaces.filter { path.usesInterfaceType($0.type) }.first?.type
        }
        monitor.start(queue: queue)
    }
}
