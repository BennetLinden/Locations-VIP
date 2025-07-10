//
//  HomeInteractor.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 08/07/2025.
//

import Foundation

final class HomeInteractor {
    private let presenter: HomePresenter
    private let getLocations: GetLocationsUseCase
    
    init(
        presenter: HomePresenter,
        dependencies: Dependencies = .default
    ) {
        self.presenter = presenter
        self.getLocations = dependencies.getLocations
    }
    
    func viewDidLoad() {
        Task {
            do {
                let locations = try await getLocations()
                print(locations)
            } catch GetLocationsError.network(let networkError) {
                print(networkError)
            } catch GetLocationsError.other(let error) {
                print(error)
            }
        }
    }
}

extension HomeInteractor {
    struct Dependencies {
        let getLocations: GetLocationsUseCase
        
        static var `default`: Self {
            Dependencies(
                getLocations: GetLocationsUseCase()
            )
        }
    }
}
