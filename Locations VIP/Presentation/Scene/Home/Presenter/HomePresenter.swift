//
//  HomePresenter.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 08/07/2025.
//

import CoreLocation
import Foundation

@MainActor
class HomePresenter {
    weak var view: HomeDisplayLogic?
    
    func presentLoading() {
        view?.display(viewModel: .loading)
    }
    
    func present(
        error: any ErrorViewModelConvertible,
        retryAction: (() -> Void)? = nil
    ) {
        let viewModel = error.asErrorViewModel(
            retryAction: retryAction
        )
        view?.display(viewModel: .error(viewModel))
    }
    
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
        
        view?.display(viewModel: .content(locations: viewModels))
    }
}
