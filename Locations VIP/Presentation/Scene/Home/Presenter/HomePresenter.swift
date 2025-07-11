//
//  HomePresenter.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 08/07/2025.
//

import CoreLocation
import Foundation

@MainActor
final class HomePresenter {
    weak var view: HomeDisplayLogic?
    
    func present(locations: [Location], userLocation: CLLocation?) {
        let viewModels = locations
            .map { location in
                let distance = userLocation.map { userLocation in
                    let destination = CLLocation(
                        latitude: location.latitude,
                        longitude: location.longitude
                    )
                    return userLocation.distance(from: destination)
                }
                
                return LocationCell.ViewModel(
                    title: location.name ?? "Unknown location",
                    distance: distance
                )
            }
            .sorted(
                using: KeyPathComparator(\.distance, order: .forward)
            )
        
        view?.displayLocations(viewModels)
    }
}
