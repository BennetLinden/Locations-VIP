//
//  HomeViewController.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 08/07/2025.
//

import UIKit

final class HomeViewController: UIViewController {
    private let contentView = HomeContentView()
    private var viewModels: [LocationCell.ViewModel] = [] {
        didSet {
            contentView.tableView.reloadData()
        }
    }
    
    private let interactor: HomeInteractor
    
    init(interactor: HomeInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    
        interactor.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        interactor.viewDidAppear()
    }
}

extension HomeViewController {
    private func setup() {
        navigationItem.title = "Home"
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
}

// MARK: - Home Display Logic
extension HomeViewController: HomeDisplayLogic {
    func displayLocations(_ viewModels: [LocationCell.ViewModel]) {
        self.viewModels = viewModels
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        let cell: LocationCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: viewModel)
        return cell
    }
}
