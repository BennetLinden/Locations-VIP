//
//  HomeViewController.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 08/07/2025.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let interactor: HomeInteractor
    
    init(interactor: HomeInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Home"
        
        interactor.viewDidLoad()
    }
}

// MARK: - Home Display Logic
extension HomeViewController: HomeDisplayLogic {
    
}
