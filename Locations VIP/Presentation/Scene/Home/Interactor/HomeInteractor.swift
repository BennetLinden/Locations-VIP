//
//  HomeInteractor.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 08/07/2025.
//

import Foundation

final class HomeInteractor {
    @Injected(\.locationService) private var locationService
    
    private let presenter: HomePresenter
    
    init(presenter: HomePresenter) {
        self.presenter = presenter
    }
    
    func viewDidLoad() {
        Task {
            do {
                let locations = try await locationService.getLocations()
                print(locations)
            } catch {
                print(error)
            }
        }
    }
}
