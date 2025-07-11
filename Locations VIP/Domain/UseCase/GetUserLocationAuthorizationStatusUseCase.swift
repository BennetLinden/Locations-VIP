//
//  GetUserLocationAuthorizationStatusUseCase.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 11/07/2025.
//

import CoreLocation
import Foundation

struct GetUserLocationAuthorizationStatusUseCase {
    private let locationManager: LocationManager

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
    }

    init() {
        @Injected(\.locationManager) var locationManager
        self.init(locationManager: locationManager)
    }

    func callAsFunction() -> CLAuthorizationStatus {
        locationManager.authorizationStatus
    }
}
