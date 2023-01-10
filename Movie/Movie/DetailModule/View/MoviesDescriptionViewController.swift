// MoviesDescriptionViewController.swift
// Copyright © RoadMap. All rights reserved.

import SwiftyJSON
import UIKit

/// Экран конкретного фильма
final class MoviesDescriptionViewController: UIViewController {
    // MARK: Private Constant

    private enum Constants {
        static let resultDateFormat = "yyyy-MM-dd"
        static let editDateFormat = "yyyy"
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
        static let imageRequestURL = "https://image.tmdb.org/t/p/w500"
        static let apiRequestURL = "https://api.themoviedb.org/3/movie/"
        static let apiKeyURL = "api_key=d9e4494907230d135d6f6fd47beca82e"
        static let apiLanguageURL = "language=ru"
        static let apiResponseURL = "append_to_response=videos"
        static let apiCreditsGenreURL = "credits"
    }

    // MARK: Private visual Components

    private let moviePosterImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 500))

    private lazy var contentScrollView: UIScrollView = {
        let scroll = UIScrollView(frame: view.bounds)
        scroll.showsVerticalScrollIndicator = false
        scroll.contentSize = CGSize(width: view.frame.width, height: 1250)
        scroll.addSubview(backgroundBlackView)
        return scroll
    }()

    private lazy var backgroundBlackView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 300, width: 400, height: 1000))
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
        label.numberOfLines = 3
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()

    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .lightGray
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
        collectionView.contentSize = CGSize(width: 1000, height: 250)
        collectionView.register(ActorCollectionViewCell.self, forCellWithReuseIdentifier: Constants.actorCellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    private let actorCollectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 150, height: 250)
        layout.scrollDirection = .horizontal
        return layout
    }()

    private let actorsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray3
        label.text = Constants.actorTitleText
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()

    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .systemGray3
        label.text = Constants.descriptionTitleText
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Private Property

    private let dateFormater = DateFormatter()
    private var networkManager = NetworkManager()
    private var actors: [Actor] = []
    private var genre = String()

    // MARK: Public Property

    var id: Int?
    var genreNet: DetailMovie?
    var genres: [DetailMovie] = []

    // MARK: - Lyfe Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureConstraint()
    }

    // MARK: Private Methods

    private func setupUI() {
        fetchDetail()
        getAndSetupAnotherUI()
    }

    private func fetchDetail() {
        guard let id else { return }
//        networkManager.fetchMovieDetail(movieId: "\(id)") { result in
//            switch result {
//            case let .success(json):
//
//                guard let genres = (json?.arrayValue.map { DetailMovie(json: $0) }) else { return }
//                self.genres = genres
//            case let .failure(error):
//                print(error)
//            }
//        }

        guard
            let url =
            URL(
                string: "\(Constants.apiRequestURL)\(id)?" +
                    "\(Constants.apiKeyURL)&\(Constants.apiResponseURL)&\(Constants.apiLanguageURL)"
            )
        else { return }
        let session = URLSession.shared
        let taskGenre = session.dataTask(with: url) { data, _, error in
            if error == nil, let parseData = data {
                guard let genre = try? JSONDecoder().decode(DetailMovie.self, from: parseData) else { return }

                self.genreNet = genre
                self.getGenres()
            }
        }
        taskGenre.resume()
    }

    func getGenres() {
        genre = String()
        guard let genres = genreNet?.genres else { return }
        for genre in genres {
            if self.genres.isEmpty {
                self.genre += genre.name
            } else {
                self.genre += ", " + genre.name
            }
        }
    }

    private func getAndSetupAnotherUI() {
        view.addSubview(moviePosterImageView)
        view.addSubview(contentScrollView)
        movieNameLabel.text = genreNet?.title
        descriptionLabel.text = genreNet?.overview
        genreLabel.text = genre
        ratingLabel.textColor = {
            guard let rating = Double(ratingLabel.text ?? String()) else { return .lightGray }
            switch rating {
            case 5 ..< 7:
                return .lightGray
            case 7 ... 10:
                return .green
            default:
                return .systemRed
            }
        }()

        guard let id else { return }

        networkManager.fetchActor(movieID: "\(id)") { result in
            switch result {
            case let .success(json):
                guard let actors = (json?["cast"].arrayValue.map { Actor(json: $0) }) else { return }
                self.actors = actors
                self.actorCollectionView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
    }

    private func configureConstraint() {
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalTo: backgroundBlackView.topAnchor, constant: 25),
            movieNameLabel.widthAnchor.constraint(equalToConstant: backgroundBlackView.frame.width - 100),
            movieNameLabel.centerXAnchor.constraint(equalTo: backgroundBlackView.centerXAnchor, constant: 0),
            ratingLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 15),
            ratingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            genreLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 5),
            genreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            seeMovieButton.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10),
            seeMovieButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            seeMovieButton.heightAnchor.constraint(equalToConstant: 70),
            seeMovieButton.widthAnchor.constraint(equalToConstant: 250),
            actorsLabel.topAnchor.constraint(equalTo: seeMovieButton.bottomAnchor, constant: 20),
            actorsLabel.leadingAnchor.constraint(equalTo: backgroundBlackView.leadingAnchor, constant: 20),
            actorCollectionView.topAnchor.constraint(equalTo: seeMovieButton.bottomAnchor, constant: 50),
            actorCollectionView.leadingAnchor.constraint(equalTo: backgroundBlackView.leadingAnchor, constant: 0),
            actorCollectionView.trailingAnchor.constraint(equalTo: backgroundBlackView.trailingAnchor, constant: 0),
            actorCollectionView.heightAnchor.constraint(equalToConstant: 250),
            actorCollectionView.widthAnchor.constraint(equalToConstant: backgroundBlackView.frame.width),
            descriptionTitleLabel.topAnchor.constraint(equalTo: actorCollectionView.bottomAnchor, constant: 15),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: backgroundBlackView.leadingAnchor, constant: 20),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: backgroundBlackView.leadingAnchor, constant: 20),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 360)
        ])
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension MoviesDescriptionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        actors.count
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
        cell.setupActor(actors[indexPath.row])
        return cell
    }
}
