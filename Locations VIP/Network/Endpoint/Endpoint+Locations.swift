//
//  Endpoint+Locations.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 11/07/2025.
//

import Foundation

extension Endpoint {
    static func locations(_ locations: Locations) -> Endpoint {
        Endpoint(
            baseUrl: .githubUserContent,
            path: locations.path
        )
    }
    
    enum Locations {
        case all
        
        var path: String {
            switch self {
            case .all: "/BennetLinden/086ac4f79439b5ad0420be0fcc4cbaa5/raw/800db4b94cbf7a525eaf79cdc4ae9d27ef424cd8/locations.json"
            }
        }
    }
}
