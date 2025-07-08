//
//  GetLocationsRequest.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 08/07/2025.
//

import Alamofire
import Foundation

struct GetLocationsRequest: NetworkRequest {
    var method: HTTPMethod {
        .get
    }
    
    var url: any URLConvertible {
        URL(string: "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json")!
    }
}
