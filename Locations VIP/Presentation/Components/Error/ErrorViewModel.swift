//
//  ErrorViewModel.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 13/07/2025.
//

import Foundation

struct ErrorViewModel {
    typealias RetryAction = () -> Void
    
    let title: String
    let message: String
    let retryAction: RetryAction?
}

extension ErrorViewModel {
    static func general(retryAction: RetryAction?) -> ErrorViewModel {
        ErrorViewModel(
            title: "Something went wrong",
            message: "Please try again.",
            retryAction: retryAction
        )
    }
}

extension ErrorViewModel {
    init(
        networkError: NetworkError,
        retryAction: RetryAction?
    ) {
        switch networkError {
        case .notConnectedToInternet, .timedOut, .networkConnectionLost, .cannotConnectToHost:
            self.init(
                title: "No Internet",
                message: "Please check your internet connection and try again.",
                retryAction: retryAction
            )
            
        case .responseDecodingFailed:
            self.init(
                title: "Unexpected Error",
                message: "The data could not be processed. Please try again later.",
                retryAction: retryAction
            )
            
        case let .unacceptableStatusCode(code, _):
            self.init(
                title: "Server Error",
                message: "Server responded with status code \(code).",
                retryAction: retryAction
            )
            
        case .authentication:
            self.init(
                title: "Authentication Error",
                message: "Your session has expired or you're not authorized. Please sign in again.",
                retryAction: retryAction
            )
            
        case .explicitlyCancelled:
            self.init(
                title: "Cancelled",
                message: "The request was cancelled.",
                retryAction: retryAction
            )
            
        case .error:
            self.init(
                title: "Unexpected Error",
                message: "Something went wrong. Please try again later.",
                retryAction: retryAction
            )
        }
    }
}
