//
//  HomeViewController.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 08/07/2025.
//

import UIKit

final class HomeViewController: UIViewController {
    private let contentView = HomeContentView()
    private var locationViewModels: [LocationCell.ViewModel] = [] {
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
        view.backgroundColor = .background
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
}

// MARK: - Home Display Logic
extension HomeViewController: HomeDisplayLogic {
    func display(viewModel: HomeViewModel) {
        switch viewModel {
        case .loading:
            contentView.tableView.isHidden = true
            contentView.loadingView.startAnimating()
            
        case .content(let locationViewModels):
            contentView.loadingView.stopAnimating()
            contentView.tableView.isHidden = false
            self.locationViewModels = locationViewModels
            
        case .error(let error):
            contentView.loadingView.stopAnimating()
            
            let alertController = UIAlertController(
                title: error.title,
                message: error.message,
                preferredStyle: .alert
            )
            alertController.addAction(
                UIAlertAction(title: "Close", style: .cancel)
            )
            if let retryAction = error.retryAction {
                alertController.addAction(
                    UIAlertAction(
                        title: "Retry",
                        style: .default
                    ) { _ in
                        retryAction()
                    }
                )
            }
            present(alertController, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locationViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = locationViewModels[indexPath.row]
        let cell: LocationCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: viewModel)
        return cell
    }
}
