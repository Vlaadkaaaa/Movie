// ActorCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Настройка  Актеров
final class ActorCollectionViewCell: UICollectionViewCell {
    // MARK: Private Constant

    private enum Constants {
        static let getImageURL = "https://image.tmdb.org/t/p/w500"
    }

    // MARK: - Private Visual Components

    private let actorImageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 5, y: 5, width: 140, height: 190))
        return image
    }()

    private let actorNameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 5, y: 200, width: 140, height: 20))
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    private let actorRoleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 5, y: 220, width: 140, height: 20))
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Init

    override private init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("")
    }

    // MARK: - Private Metods

    private func setupUI() {
        addSubview(actorImageView)
        addSubview(actorNameLabel)
        addSubview(actorRoleLabel)
        actorImageView.layer.cornerRadius = 20
        actorImageView.clipsToBounds = true
    }

    // MARK: - Public Metods

    func configureCell(_ actror: Actor) {
        actorNameLabel.text = actror.name
        actorRoleLabel.text = actror.character
        guard let profilePath = actror.profilePath,
              let urlImage = URL(string: Constants.getImageURL + profilePath)
        else { return }
        ImageRequest(url: urlImage).execute { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(image):
                self.actorImageView.image = image
            case let .failure(error):
                print(error)
            }
        }
    }
}
