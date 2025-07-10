//
//  LocationService.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 08/07/2025.
//

import Foundation

protocol LocationService {
    func getLocations() async throws -> LocationsDTO
}

actor DefaultLocationService: LocationService {
    private let network: Network

    init(
        network: Network,
    ) {
        self.network = network
    }

    init() {
        @Injected(\.network) var network
        self.init(
            network: network,
        )
    }
    
    func getLocations() async throws -> LocationsDTO {
        try await network.request(
            GetLocationsRequest()
        )
    }
}
