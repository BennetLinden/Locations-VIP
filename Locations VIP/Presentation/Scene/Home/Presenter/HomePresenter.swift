//
//  HomePresenter.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 08/07/2025.
//

import Foundation

@MainActor
final class HomePresenter {
    weak var view: HomeDisplayLogic?
    
    func presentLocations(_ locations: [Location]) {
        let viewModels = locations.map { location in
            LocationCell.ViewModel(
                title: location.name ?? "Unknown location"
            )
        }
        view?.displayLocations(viewModels)
    }
}
