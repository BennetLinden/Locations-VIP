//
//  HomeView.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 10/07/2025.
//

import UIKit

final class HomeContentView: UIView {
    private(set) lazy var tableView = UITableView.configure { tableView in
        tableView.register(cellType: LocationCell.self)
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
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
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
