// MovieViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
final class MovieViewCell: UITableViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label)
        configureLabel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}
