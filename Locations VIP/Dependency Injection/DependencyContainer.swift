//
//  DependencyContainer.swift
//
//  Created by Bennet van der Linden on 27/06/2022.
//

import Foundation

struct DependencyContainer {
    private static var shared = DependencyContainer()
    
    /// A static subscript for accessing the `value` of `InjectionKey` instances.
    static subscript<Key: InjectionKey>(key: Key.Type) -> Key.Value {
        key.value
    }
    
    /// A static subscript accessor for reading dependencies in the shared container.
    static subscript<Value>(
        _ keyPath: KeyPath<DependencyContainer, Value>
    ) -> Value {
        shared[keyPath: keyPath]
    }
}

// MARK: - Network

extension DependencyContainer {
    private struct NetworkKey: InjectionKey {
        static let value = NetworkService(session: .default)
    }

    var network: Network {
        DependencyContainer[NetworkKey.self]
    }
}

// MARK: - Location Service

extension DependencyContainer {
    private struct LocationServiceKey: InjectionKey {
        static let value = DefaultLocationService()
    }

    var locationService: LocationService {
        DependencyContainer[LocationServiceKey.self]
    }
}

// MARK: - Location Manager

extension DependencyContainer {
    private struct LocationManagerKey: InjectionKey {
        static let value = DefaultLocationManager()
    }

    var locationManager: LocationManager {
        DependencyContainer[LocationManagerKey.self]
    }
}
