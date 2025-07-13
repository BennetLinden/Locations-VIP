//
//  HomeViewModel.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 13/07/2025.
//

import Foundation

enum HomeViewModel {
    case loading
    case content(locations: [LocationCell.ViewModel])
    case error(ErrorViewModel)
}
