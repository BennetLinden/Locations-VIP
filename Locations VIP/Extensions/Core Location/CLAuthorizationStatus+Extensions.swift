//
//  CLAuthorizationStatus+Extensions.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 11/07/2025.
//

import Foundation

import CoreLocation

extension CLAuthorizationStatus {
    var isAuthorized: Bool {
        switch self {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        default:
            return false
        }
    }

    var isNotDetermined: Bool {
        self == .notDetermined
    }
}
