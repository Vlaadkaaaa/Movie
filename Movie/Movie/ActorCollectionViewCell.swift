// ActorCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class ActorCollectionViewCell: UICollectionViewCell {
    // MARK: Visual Components

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

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(actorImageView)
        addSubview(actorNameLabel)
        addSubview(actorRoleLabel)
        actorImageView.layer.cornerRadius = 20
        actorImageView.clipsToBounds = true
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(actror: Actor) {
        DispatchQueue.main.async {
            guard let urlImage = URL(string: "https://image.tmdb.org/t/p/w500" + actror.actorImageName) else { return }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlImage) { data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.actorImageView.image = image
                }
            }
            task.resume()
        }
        actorNameLabel.text = actror.actorName
        actorRoleLabel.text = actror.actorRoleName
    }
}
