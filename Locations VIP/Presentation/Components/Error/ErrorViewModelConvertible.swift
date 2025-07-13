//
//  ErrorPresentable.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 13/07/2025.
//

import Foundation

protocol ErrorViewModelConvertible {
    func asErrorViewModel(
        retryAction: ErrorViewModel.RetryAction?
    ) -> ErrorViewModel
}
