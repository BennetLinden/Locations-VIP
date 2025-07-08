//
//  Location.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 08/07/2025.
//

import Foundation

struct Location {
    let name: String?
    let latitude, longitude: Double
    
    init(dto: LocationDTO) {
        name = dto.name
        latitude = dto.latitude
        longitude = dto.longitude
    }
}
