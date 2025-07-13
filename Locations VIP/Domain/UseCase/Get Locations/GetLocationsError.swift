//
//  GetLocationsError.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 13/07/2025.
//

import Foundation

enum GetLocationsError: Error {
    case network(NetworkError)
    case other(Error)
    
    init(_ error: Error) {
        switch error {
        case let error as NetworkError:
            self = .network(error)
        default:
            self = .other(error)
        }
    }
    
    var isConnectivityError: Bool {
        switch self {
        case .network(let error):
            return error.isConnectivityError
        default:
            return false
        }
    }
}

extension GetLocationsError: ErrorViewModelConvertible {
    func asErrorViewModel(
        retryAction: ErrorViewModel.RetryAction?
    ) -> ErrorViewModel {
        switch self {
        case .network(let networkError):
            ErrorViewModel(
                networkError: networkError,
                retryAction: retryAction
            )
        case .other:
            ErrorViewModel.general(
                retryAction: retryAction
            )
        }
    }
}
