//
//  HomeInteractor.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 08/07/2025.
//

import CoreLocation
import Foundation

@MainActor
final class HomeInteractor {
    private let presenter: HomePresenter
    
    private let getLocations: GetLocationsUseCase
    
    private let locationManager: LocationManager
    private let requestUserLocationAuthorization: RequestUserLocationAuthorizationUseCase
    private let startLocationUpdates: StartLocationUpdatesUseCase
    
    private var locations: [Location] = []
    private var userLocation: CLLocation?
    
    init(
        presenter: HomePresenter,
        dependencies: Dependencies = .default
    ) {
        self.presenter = presenter
        getLocations = dependencies.getLocations
        locationManager = dependencies.locationManager
        requestUserLocationAuthorization = dependencies.requestUserLocationAuthorization
        startLocationUpdates = dependencies.startLocationUpdates
    }
    
    private func loadLocations() {
        Task {
            presenter.presentLoading()
            do {
                locations = try await getLocations()
                presenter.present(locations: locations, userLocation: userLocation)
            } catch let error as GetLocationsError where error.isConnectivityError {
                presenter.present(
                    error: error,
                    retry: loadLocations
                )
            } catch {
                presenter.present(
                    error: error
                )
            }
        }
    }

    private func authorizeAndStartLocationUpdates() {
        Task {
            let status = await requestUserLocationAuthorization()

            guard status.isAuthorized else {
                return
            }
            startLocationUpdates()

            for await userLocation in locationManager.locationUpdates {
                if locations.isNotEmpty {
                    presenter.present(
                        locations: locations,
                        userLocation: userLocation
                    )
                }
            }
        }
    }
}

extension HomeInteractor {
    func viewDidLoad() {
        loadLocations()
    }
    
    func viewDidAppear() {
        authorizeAndStartLocationUpdates()
    }
}

extension HomeInteractor {
    struct Dependencies {
        let getLocations: GetLocationsUseCase
        let locationManager: LocationManager
        let requestUserLocationAuthorization: RequestUserLocationAuthorizationUseCase
        let startLocationUpdates: StartLocationUpdatesUseCase
        
        static var `default`: Self {
            @Injected(\.locationManager) var locationManager

            return Dependencies(
                getLocations: GetLocationsUseCase(),
                locationManager: locationManager,
                requestUserLocationAuthorization: RequestUserLocationAuthorizationUseCase(),
                startLocationUpdates: StartLocationUpdatesUseCase()
            )
        }
    }
}
