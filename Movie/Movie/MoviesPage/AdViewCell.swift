// AdViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Настройка блока рекламы
final class AdViewCell: UITableViewCell {
    // MARK: - Private Contants

    private enum Constants {
        static let adTitleText = "РЕКЛАМА"
    }

    // MARK: - Private Visual Components

    private let adImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let adLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.alpha = 0.8
        label.text = Constants.adTitleText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(adImageView)
        addSubview(adLabel)
        configureItemView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("")
    }

    // MARK: - Public Method

    func setupUI(name: String) {
        adImageView.image = UIImage(named: name)
    }

    // MARK: - Private Method

    private func configureItemView() {
        adImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        adImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        adImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        adImageView.widthAnchor.constraint(equalToConstant: 370).isActive = true
        adImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        adLabel.topAnchor.constraint(equalTo: adImageView.topAnchor, constant: 10).isActive = true
        adLabel.leadingAnchor.constraint(equalTo: adImageView.leadingAnchor, constant: 10).isActive = true
    }
}
