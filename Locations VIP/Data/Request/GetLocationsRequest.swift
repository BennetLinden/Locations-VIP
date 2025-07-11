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
        Endpoint.locations(.all)
    }
}
