//
//  HomeInteractorTests.swift
//  Locations VIP Tests
//
//  Created by Bennet van der Linden on 13/07/2025.
//

import CoreLocation
@testable import Locations_VIP
import XCTest

@MainActor
final class HomeInteractorTests: XCTestCase {

    private var presenter: MockHomePresenter!
    private var locationService: MockLocationService!
    private var locationManager: MockLocationManager!
    
    private var sut: HomeInteractor!
    
    override func setUpWithError() throws {
        presenter = MockHomePresenter()
        locationService = MockLocationService()
        locationManager = MockLocationManager()
        
        let dependencies = HomeInteractor.Dependencies(
            getLocations: GetLocationsUseCase(
                locationService: locationService
            ),
            locationManager: locationManager,
            requestUserLocationAuthorization: RequestUserLocationAuthorizationUseCase(
                locationManager: locationManager
            ),
            startLocationUpdates: StartLocationUpdatesUseCase(
                locationManager: locationManager
            )
        )
        
        sut = HomeInteractor(
            presenter: presenter,
            dependencies: dependencies
        )
    }

    override func tearDownWithError() throws {
        presenter = nil
        locationService = nil
        locationManager = nil
        sut = nil
    }
    
    func test_viewDidLoad_success() async {
        // Given
        locationService.stubbedLocations = [
            LocationDTO(name: "Amsterdam", latitude: 52.3547498, longitude: 4.8339215)
        ]

        // When
        sut.viewDidLoad()
        try? await Task.sleep(nanoseconds: 100_000_000)

        // Then
        XCTAssertTrue(presenter.presentLoadingCalled)
        XCTAssertEqual(presenter.presentedLocations?.first?.name, "Amsterdam")
    }
    
    func test_viewDidLoad_error() async {
        // Given
        locationService.errorToThrow = NetworkError.notConnectedToInternet

        // When
        sut.viewDidLoad()
        try? await Task.sleep(nanoseconds: 100_000_000)

        // Then
        XCTAssertTrue(presenter.presentLoadingCalled)
        XCTAssertNotNil(presenter.presentedError)
    }
    
    func test_viewDidAppear_authorized_receivesLocationUpdates() async {
        // Given
        locationManager.stubbedAuthorizationStatus = .authorizedWhenInUse
        locationManager.stubbedRequestResult = .authorizedWhenInUse
        locationManager.stubbedLocationStream = [
            CLLocation(latitude: 52.37, longitude: 4.89)
        ]
        locationService.stubbedLocations = [
            LocationDTO(name: "Amsterdam", latitude: 52.3547498, longitude: 4.8339215)
        ]

        // When
        sut.viewDidLoad()
        try? await Task.sleep(nanoseconds: 100_000_000)

        sut.viewDidAppear()
        try? await Task.sleep(nanoseconds: 100_000_000)

        // Then
        XCTAssertTrue(locationManager.startUpdatingLocationCalled)
        XCTAssertEqual(presenter.presentedLocationsWithUserLocation?.userLocation?.coordinate.latitude, 52.37)
        XCTAssertEqual(presenter.presentedLocationsWithUserLocation?.userLocation?.coordinate.longitude, 4.89)
        XCTAssertEqual(presenter.presentedLocationsWithUserLocation?.locations.first?.name, "Amsterdam")
    }
    
    func test_viewDidAppear_denied_doesNotStartUpdates() async {
        // Given
        locationManager.stubbedRequestResult = .denied

        // When
        sut.viewDidAppear()
        try? await Task.sleep(nanoseconds: 100_000_000)

        // Then
        XCTAssertFalse(locationManager.startUpdatingLocationCalled)
        XCTAssertNil(presenter.presentedLocationsWithUserLocation)
    }
}
