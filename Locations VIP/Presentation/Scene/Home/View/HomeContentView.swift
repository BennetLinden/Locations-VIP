//
//  HomeView.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 10/07/2025.
//

import UIKit

final class HomeContentView: UIView {
    
    private(set) lazy var collectionView = UICollectionView.configure { collectionView in
        
    }
    
    init() {
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
    }
}
