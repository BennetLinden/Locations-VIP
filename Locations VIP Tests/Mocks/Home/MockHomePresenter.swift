//
//  MockHomePresenter.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 13/07/2025.
//

import CoreLocation
@testable import Locations_VIP
import XCTest

final class MockHomePresenter: HomePresenter {
    var presentLoadingCalled = false
    var presentedLocations: [Location]?
    var presentedLocationsWithUserLocation: (locations: [Location], userLocation: CLLocation?)?
    var presentedError: (error: any ErrorViewModelConvertible, retryAction: (() -> Void)?)?

    override func presentLoading() {
        presentLoadingCalled = true
    }

    override func present(locations: [Location], userLocation: CLLocation?) {
        if let userLocation = userLocation {
            presentedLocationsWithUserLocation = (locations, userLocation)
        } else {
            presentedLocations = locations
        }
    }

    override func present(error: any ErrorViewModelConvertible, retryAction: (() -> Void)? = nil) {
        presentedError = (error, retryAction)
    }
}
