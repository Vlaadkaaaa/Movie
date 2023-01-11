// DescriptionViewController.swift
// Copyright © RoadMap. All rights reserved.

import SwiftyJSON
import UIKit

/// Экран конкретного фильма
final class DescriptionViewController: UIViewController {
    // MARK: Private Constant

    private enum Constants {
        static let watchImageName = "watch"
        static let actorCellIdentifier = "ActorCell"
        static let actorTitleText = "Актеры"
        static let descriptionTitleText = "Описание"
        static let starSystemImageName = "star.fill"
        static let bookmarkSystemImageName = "bookmark.fill"
        static let shareSystemImageName = "square.and.arrow.up.fill"
        static let moreSystemImageName = "ellipsis"
        static let favoriteTitleText = "Оценить"
        static let bookmarkTitleText = "Буду смотреть"
        static let shareTitleText = "Поделиться"
        static let moreTitleText = "Ещё"
        static let titleErrorText = "Ошибочка"
        static let getImageURL = "https://image.tmdb.org/t/p/w500"
        static let viewWidthSizeNumber = 400
        static let posterImageViewHeightNumber = 500
        static let scrollHeightSizeNumber: CGFloat = 1250
        static let viewYPositionNumber = 300
        static let viewHeightSizeNumber = 1000
        static let textThreeLinesNumber = 3
        static let textZeroLinesNumber = 0
        static let titleFontSizeNumber: CGFloat = 20
        static let defaultFontSizeNumber: CGFloat = 14
        static let contentWidthSizeNumber: CGFloat = 1000
        static let contentHeightSizeNumber: CGFloat = 250
        static let sectionInsetNumber: CGFloat = 10
        static let layoutWidthSizeNumber: CGFloat = 150
        static let layoutHeightSizeNumber: CGFloat = 250
        static let twentyAnchorNumber: CGFloat = 20
        static let fiveAnchorNumber: CGFloat = 5
        static let zeroAnchorNumber: CGFloat = 0
        static let tenAnchorNumber: CGFloat = 10
        static let oneHundredAnchorNumber: CGFloat = 100
        static let twentyFiveHundridNumber: CGFloat = 250
        static let threeHundridNumber: CGFloat = 300
        static let seventyAnchorNumber: CGFloat = 70
        static let fivtyAnchorNumber: CGFloat = 50
        static let thirtyFiveHundredNumber: CGFloat = 350
    }

    // MARK: Private visual Components

    private let moviePosterImageView =
        UIImageView(frame: CGRect(
            x: 0,
            y: 0,
            width: Constants.viewWidthSizeNumber,
            height: Constants.posterImageViewHeightNumber
        ))

    private lazy var contentScrollView: UIScrollView = {
        let scroll = UIScrollView(frame: view.bounds)
        scroll.showsVerticalScrollIndicator = false
        scroll.contentSize = CGSize(width: view.frame.width, height: Constants.scrollHeightSizeNumber)
        scroll.addSubview(backgroundBlackView)
        return scroll
    }()

    private lazy var backgroundBlackView: UIView = {
        let view = UIView(frame: CGRect(
            x: 0,
            y: Constants.viewYPositionNumber,
            width: Constants.viewWidthSizeNumber,
            height: Constants.viewHeightSizeNumber
        ))
        view.backgroundColor = .black
        view.tintColor = .systemGray
        view.addSubview(movieNameLabel)
        view.addSubview(ratingLabel)
        view.addSubview(genreLabel)
        view.addSubview(seeMovieButton)
        view.addSubview(actorCollectionView)
        view.addSubview(actorsLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTitleLabel)
        return view
    }()

    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = Constants.textThreeLinesNumber
        label.font = .boldSystemFont(ofSize: Constants.titleFontSizeNumber)
        return label
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Constants.defaultFontSizeNumber)
        label.textAlignment = .center
        return label
    }()

    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.defaultFontSizeNumber)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.numberOfLines = Constants.textZeroLinesNumber
        return label
    }()

    private let seeMovieButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: Constants.watchImageName), for: .normal)
        return button
    }()

    private lazy var actorCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: actorCollectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .black
        collectionView.contentSize = CGSize(
            width: Constants.contentWidthSizeNumber,
            height: Constants.contentHeightSizeNumber
        )
        collectionView.register(ActorCollectionViewCell.self, forCellWithReuseIdentifier: Constants.actorCellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    private let actorCollectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(
            top: Constants.sectionInsetNumber,
            left: Constants.sectionInsetNumber,
            bottom: Constants.sectionInsetNumber,
            right: Constants.sectionInsetNumber
        )
        layout.itemSize = CGSize(width: Constants.layoutWidthSizeNumber, height: Constants.layoutHeightSizeNumber)
        layout.scrollDirection = .horizontal
        return layout
    }()

    private let actorsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray3
        label.text = Constants.actorTitleText
        label.font = .boldSystemFont(ofSize: Constants.titleFontSizeNumber)
        return label
    }()

    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Constants.titleFontSizeNumber)
        label.textColor = .systemGray3
        label.text = Constants.descriptionTitleText
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.defaultFontSizeNumber)
        label.textColor = .systemGray
        label.numberOfLines = Constants.textZeroLinesNumber
        return label
    }()

    // MARK: - Private Property

    private var genre = String()

    // MARK: Public Property

    var presenter: DetailPresenerProtocol?

    // MARK: - Lyfe Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: Private Methods

    private func setupUI() {
        view.addSubview(moviePosterImageView)
        view.addSubview(contentScrollView)
        presenter?.fetchDetail()
        presenter?.fetchActorDetail()
        configureConstraint()
    }

    private func getGenres() {
        presenter?.details?.genres.forEach {
            genre += $0 + " "
        }
    }

    private func fetchImage() {
        guard let profilePath = presenter?.details?.posterPath else { return }
        let urlImage = "\(Constants.getImageURL)\(profilePath)"
        presenter?.networkService.fetchImage(url: urlImage) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(data):
                self.moviePosterImageView.image = UIImage(data: data)
            case let .failure(error):
                self.showAlert(title: Constants.titleErrorText, message: error.localizedDescription)
            }
        }
    }

    private func configureConstraint() {
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(
                equalTo: backgroundBlackView.topAnchor,
                constant: Constants.twentyAnchorNumber
            ),
            movieNameLabel.widthAnchor
                .constraint(equalToConstant: backgroundBlackView.frame.width - Constants.oneHundredAnchorNumber),
            movieNameLabel.centerXAnchor.constraint(
                equalTo: backgroundBlackView.centerXAnchor,
                constant: Constants.zeroAnchorNumber
            ),
            ratingLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: Constants.tenAnchorNumber),
            ratingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: Constants.zeroAnchorNumber),
            genreLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: Constants.fiveAnchorNumber),
            genreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: Constants.zeroAnchorNumber),
            genreLabel.widthAnchor.constraint(equalToConstant: Constants.threeHundridNumber),
            seeMovieButton.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: Constants.tenAnchorNumber),
            seeMovieButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: Constants.zeroAnchorNumber),
            seeMovieButton.heightAnchor.constraint(equalToConstant: Constants.seventyAnchorNumber),
            seeMovieButton.widthAnchor.constraint(equalToConstant: Constants.twentyFiveHundridNumber),
            actorsLabel.topAnchor.constraint(
                equalTo: seeMovieButton.bottomAnchor,
                constant: Constants.twentyAnchorNumber
            ),
            actorsLabel.leadingAnchor.constraint(
                equalTo: backgroundBlackView.leadingAnchor,
                constant: Constants.twentyAnchorNumber
            ),
            actorCollectionView.topAnchor.constraint(
                equalTo: seeMovieButton.bottomAnchor,
                constant: Constants.fivtyAnchorNumber
            ),
            actorCollectionView.leadingAnchor.constraint(
                equalTo: backgroundBlackView.leadingAnchor,
                constant: Constants.zeroAnchorNumber
            ),
            actorCollectionView.trailingAnchor.constraint(
                equalTo: backgroundBlackView.trailingAnchor,
                constant: Constants.zeroAnchorNumber
            ),
            actorCollectionView.heightAnchor.constraint(equalToConstant: Constants.twentyFiveHundridNumber),
            actorCollectionView.widthAnchor.constraint(equalToConstant: backgroundBlackView.frame.width),
            descriptionTitleLabel.topAnchor.constraint(
                equalTo: actorCollectionView.bottomAnchor,
                constant: Constants.fivtyAnchorNumber
            ),
            descriptionTitleLabel.leadingAnchor.constraint(
                equalTo: backgroundBlackView.leadingAnchor,
                constant: Constants.twentyAnchorNumber
            ),
            descriptionLabel.topAnchor.constraint(
                equalTo: descriptionTitleLabel.bottomAnchor,
                constant: Constants.tenAnchorNumber
            ),
            descriptionLabel.leadingAnchor.constraint(
                equalTo: backgroundBlackView.leadingAnchor,
                constant: Constants.twentyAnchorNumber
            ),
            descriptionLabel.widthAnchor.constraint(equalToConstant: Constants.thirtyFiveHundredNumber)
        ])
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension DescriptionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.actors.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(
                withReuseIdentifier: Constants.actorCellIdentifier,
                for: indexPath
            ) as? ActorCollectionViewCell
        else { return UICollectionViewCell() }
        guard let actor = presenter?.actors[indexPath.row],
              let networkService = presenter?.networkService else { return UICollectionViewCell() }
        cell.configureCell(actor, networkService: networkService)
        cell.delegate = self
        return cell
    }
}

// MARK: - DetailViewProtocol

extension DescriptionViewController: DetailViewProtocol {
    func succes() {
        actorCollectionView.reloadData()
    }

    func failure(error: Error) {
        showAlert(title: Constants.titleErrorText, message: error.localizedDescription)
    }

    func setupUI(detail: DetailMovie?) {
        movieNameLabel.text = presenter?.details?.title
        descriptionLabel.text = presenter?.details?.overview
        getGenres()
        genreLabel.text = genre
        fetchImage()
    }
}

// MARK: - ViewCellDelegate

extension DescriptionViewController: ViewCellDelegate {
    func showAlert(error: Error) {
        showAlert(title: Constants.titleErrorText, message: error.localizedDescription)
    }
}
