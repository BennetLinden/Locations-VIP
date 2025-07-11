//
//  LocationCell.swift
//  Locations VIP
//
//  Created by Bennet van der Linden on 10/07/2025.
//

import UIKit
import SnapKit

final class LocationCell: UITableViewCell, Reusable {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var nameLabel = UILabel.configure { nameLabel in
        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textAlignment = .left
    }
    
    private lazy var distanceLabel = UILabel.configure { nameLabel in
        nameLabel.font = .systemFont(ofSize: 14, weight: .regular)
        nameLabel.textAlignment = .right
    }

    private func setup() {
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
        
        contentView.addSubview(distanceLabel)
        distanceLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.firstBaseline.equalTo(nameLabel)
        }
    }
    
    func configure(with viewModel: ViewModel) {
        nameLabel.text = viewModel.title
        distanceLabel.text = viewModel.formattedDistance
    }
}
