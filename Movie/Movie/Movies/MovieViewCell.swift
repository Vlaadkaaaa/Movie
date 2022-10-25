// MovieViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
final class MovieViewCell: UITableViewCell {
    // MARK: - Private Visual Components

    private let movieImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.contentMode = .scaleToFill
        return image
    }()

    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()

    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16)
        label.text = "Комедия, триллер"
        return label
    }()

    private let movieDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15)
        return label
    }()

    private let movieAgeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "18+"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .lightGray
        return label
    }()

    private let movieRatingImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(movieImageView)
        addSubview(movieNameLabel)
        addSubview(genreLabel)
        addSubview(movieDescriptionLabel)
        addSubview(movieAgeLabel)
        addSubview(movieRatingImageView)
        configureConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(movie: Movies) {
        guard let urlImage = URL(string: "https://image.tmdb.org/t/p/w500" + movie.movieImageName) else { return }
        guard let image = try? UIImage(data: Data(contentsOf: urlImage)) else { return }
        movieImageView.image = image
        movieNameLabel.text = movie.movieNameText
        movieDescriptionLabel.text = movie.movieDescriptionText
        movieRatingImageView.image = {
            switch movie.ratingValue {
            case 0 ... 2: return UIImage(named: "oneStar")
            case 2 ... 4: return UIImage(named: "twoStar")
            case 4 ... 6: return UIImage(named: "threeStar")
            case 6 ... 8: return UIImage(named: "fourStar")
            case 8 ... 10: return UIImage(named: "fiveStar")
            default: return UIImage(named: "oneStar")
            }
        }()
    }

    // MARK: Private Methods

    private func configureConstraints() {
        movieImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        movieImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        movieNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        movieNameLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20).isActive = true
        movieNameLabel.widthAnchor.constraint(equalToConstant: 260).isActive = true
        genreLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 5).isActive = true
        genreLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20).isActive = true
        movieDescriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            .isActive = true
        movieDescriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true

        movieAgeLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20).isActive = true
        movieRatingImageView.topAnchor.constraint(equalTo: movieAgeLabel.bottomAnchor, constant: 0).isActive = true
        movieRatingImageView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 15)
            .isActive = true
        movieRatingImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -200).isActive = true
        movieRatingImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        movieRatingImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}
