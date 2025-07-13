//
//  MockLocationService.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 13/07/2025.
//

@testable import Locations_VIP
import XCTest

final class MockLocationService: LocationService {
    var errorToThrow: (any Error)?
    var stubbedLocations: [LocationDTO] = []

    func getLocations() async throws -> LocationsDTO {
        if let errorToThrow {
            throw errorToThrow
        }
        return LocationsDTO(
            locations: stubbedLocations
        )
    }
}
