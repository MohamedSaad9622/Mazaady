//
//  NetworkMonitor.swift
//  MazaadyTask
//
//  Created by Mohamed Saad on 13/04/2025.
//

import Network
import Combine
import UIKit

class NetworkMonitor {
    static let shared = NetworkMonitor()

    private let monitor: NWPathMonitor
    private let queue = DispatchQueue.global(qos: .background)
    private let connectivitySubject: CurrentValueSubject<Bool, Never>
    
    /// Exposes connectivity changes as a Combine publisher.
    var connectivityPublisher: AnyPublisher<Bool, Never> {
        connectivitySubject.eraseToAnyPublisher()
    }
    
    /// Provides a convenient way to check the current connectivity status.
    var isConnected: Bool {
        connectivitySubject.value
    }
    
    private init() {
        monitor = NWPathMonitor()
        connectivitySubject = CurrentValueSubject<Bool, Never>(false)
        monitor.pathUpdateHandler = { path in
            let connected = (path.status == .satisfied)
            self.connectivitySubject.send(connected)
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: .networkStatusChanged, object: nil)
            }
        }
        monitor.start(queue: queue)
    }
}

extension Notification.Name {
    static let networkStatusChanged = Notification.Name("networkStatusChanged")
}
