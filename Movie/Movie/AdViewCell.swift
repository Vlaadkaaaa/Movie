// AdViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
final class AdViewCell: UITableViewCell {
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
        label.text = "РЕКЛАМА"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(adImageView)
        addSubview(adLabel)
        configureItemView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(name: String) {
        adImageView.image = UIImage(named: name)
    }

    func configureItemView() {
        adImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        adImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        adImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        adImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        adImageView.widthAnchor.constraint(equalToConstant: 370).isActive = true
        adImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true

        adLabel.topAnchor.constraint(equalTo: adImageView.topAnchor, constant: 10).isActive = true
        adLabel.leadingAnchor.constraint(equalTo: adImageView.leadingAnchor, constant: 10).isActive = true
    }
}
