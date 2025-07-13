//
//  MockLocationManager.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 13/07/2025.
//

import CoreLocation
@testable import Locations_VIP
import XCTest

final class MockLocationManager: LocationManager {
    var stubbedAuthorizationStatus: CLAuthorizationStatus = .notDetermined
    var stubbedRequestResult: CLAuthorizationStatus = .authorizedWhenInUse
    var stubbedLocationStream: [CLLocation] = []

    var startUpdatingLocationCalled = false

    var authorizationStatus: CLAuthorizationStatus {
        stubbedAuthorizationStatus
    }

    func requestWhenInUseAuthorization() async -> CLAuthorizationStatus {
        stubbedRequestResult
    }

    var locationUpdates: AsyncStream<CLLocation> {
        AsyncStream { continuation in
            stubbedLocationStream.forEach { continuation.yield($0) }
            continuation.finish()
        }
    }

    func startUpdatingLocation() {
        startUpdatingLocationCalled = true
    }

    func stopUpdatingLocation() {
        // no-op for tests
    }
}
