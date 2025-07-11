//
//  LocationCell+ViewModel.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 10/07/2025.
//

import Foundation

extension LocationCell {
    struct ViewModel {
        let title: String
        let distance: Double?
        
        var formattedDistance: String? {
            guard let distance else { return nil }
            
            return Measurement(
                value: distance,
                unit: UnitLength.meters
            )
            .formatted(.measurement(
                    width: .abbreviated,
                    usage: .road
            ))
        }
    }
}
