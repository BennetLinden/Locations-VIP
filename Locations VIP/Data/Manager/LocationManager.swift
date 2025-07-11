//
//  LocationManager.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 11/07/2025.
//

import CoreLocation
import Foundation

protocol LocationManager {
    var authorizationStatus: CLAuthorizationStatus { get }
    func requestWhenInUseAuthorization() async -> CLAuthorizationStatus
    
    var locationUpdates: AsyncStream<CLLocation> { get }
    func startUpdatingLocation()
    func stopUpdatingLocation()
}

final class DefaultLocationManager: NSObject, LocationManager {
    private let locationManager = CLLocationManager()
    
    private var locationContinuation: AsyncStream<CLLocation>.Continuation?
    private var authorizationContinuation: CheckedContinuation<CLAuthorizationStatus, Never>?
    
    private lazy var locationStream = AsyncStream<CLLocation> { continuation in
        self.locationContinuation = continuation
    }
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    var authorizationStatus: CLAuthorizationStatus {
        locationManager.authorizationStatus
    }
    
    func requestWhenInUseAuthorization() async -> CLAuthorizationStatus {
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined:
            return await withCheckedContinuation { continuation in
                self.authorizationContinuation = continuation
                locationManager.requestWhenInUseAuthorization()
            }
        default:
            return status
        }
    }
    
    var locationUpdates: AsyncStream<CLLocation> {
        locationStream
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}

extension DefaultLocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationContinuation?.resume(
            returning: manager.authorizationStatus
        )
        authorizationContinuation = nil
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationContinuation?.yield(location)
    }
}
