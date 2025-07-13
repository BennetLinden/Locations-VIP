//
//  GetLocationsUseCase.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 10/07/2025.
//

import Foundation

enum GetLocationsError: Error {
    case network(NetworkError)
    case other(Error)
    
    init(_ error: Error) {
        switch error {
        case let error as NetworkError:
            self = .network(error)
        default:
            self = .other(error)
        }
    }
    
    var isConnectivityError: Bool {
        switch self {
        case .network(let error):
            return error.isConnectivityError
        default:
            return false
        }
    }
}

struct GetLocationsUseCase {
    private let locationService: LocationService
    
    init(locationService: LocationService) {
        self.locationService = locationService
    }
    
    init () {
        @Injected(\.locationService) var locationService
        self.init(locationService: locationService)
    }
    
    func callAsFunction() async throws(GetLocationsError) -> [Location] {
        do {
            let dto = try await locationService.getLocations()
            return dto.locations.map(Location.init(dto:))
        } catch {
            throw GetLocationsError(error)
        }
    }
}
