// Created on 04/09/2023.

import Foundation

enum AuthenticationError: Error, Equatable {
    case unauthorized
    case refreshTokenExpiredOrInvalid
    case missingCredential
    case excessiveRefresh
}
