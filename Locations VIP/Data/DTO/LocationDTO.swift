//
//  LocationDTO.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 08/07/2025.
//

import Foundation

struct LocationDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "long"
    }
    
    let name: String?
    let latitude, longitude: Double
}
