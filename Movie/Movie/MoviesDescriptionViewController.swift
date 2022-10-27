// MoviesDescriptionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class MoviesDescriptionViewController: UIViewController {
    // MARK: Private visual Components

    lazy var moviePosterImageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 500))

        return image
    }()

    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: view.bounds)
        scroll.contentSize = CGSize(width: view.frame.width, height: 1250)
        scroll.addSubview(viewBack)
        return scroll
    }()

    lazy var viewBack: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 300, width: 400, height: 1000))
        view.backgroundColor = .black
        view.addSubview(movieNameLabel)
        view.addSubview(ratingLabel)
        view.addSubview(genreLabel)
        view.addSubview(seeMovieButton)
        view.addSubview(tabBarActionView)
        view.addSubview(actorCollectionView)
        view.addSubview(actorsLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTitleLabel)
        return view
    }()

    let movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()

    let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()

    let seeMovieButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "waths"), for: .normal)
        return button
    }()

    private lazy var actorCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 150, height: 300)
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentSize = CGSize(width: 1000, height: 300)
        collectionView.register(ActorCollectionViewCell.self, forCellWithReuseIdentifier: "ActorCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    private let actorsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Актеры"
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()

    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "Описание"
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()

    // MARK: Property

    private var genres = ""

    private let tabBarActionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        let favotiteButton = UIButton()
        favotiteButton.translatesAutoresizingMaskIntoConstraints = false
        favotiteButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        let favotiteLabel = UILabel()
        favotiteLabel.translatesAutoresizingMaskIntoConstraints = false
        favotiteLabel.text = "Оценить"
        favotiteLabel.font = .systemFont(ofSize: 11)
        let bookmarkButton = UIButton()
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        bookmarkButton.setBackgroundImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        let bookmarkLabel = UILabel()
        bookmarkLabel.translatesAutoresizingMaskIntoConstraints = false
        bookmarkLabel.text = "Буду смотреть"
        bookmarkLabel.font = .systemFont(ofSize: 11)
        let shareButton = UIButton()
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.setBackgroundImage(UIImage(systemName: "square.and.arrow.up.fill"), for: .normal)
        let shareLabel = UILabel()
        shareLabel.translatesAutoresizingMaskIntoConstraints = false
        shareLabel.text = "Поделиться"
        shareLabel.font = .systemFont(ofSize: 11)
        let moreButton = UIButton()
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        moreButton.setBackgroundImage(UIImage(systemName: "ellipsis"), for: .normal)
        let moreLabel = UILabel()
        moreLabel.translatesAutoresizingMaskIntoConstraints = false
        moreLabel.text = "Ещё"
        moreLabel.font = .systemFont(ofSize: 11)

        view.tintColor = .lightGray
        view.addSubview(favotiteButton)
        view.addSubview(favotiteLabel)
        view.addSubview(bookmarkButton)
        view.addSubview(bookmarkLabel)
        view.addSubview(shareButton)
        view.addSubview(shareLabel)
        view.addSubview(moreButton)
        view.addSubview(moreLabel)

        NSLayoutConstraint.activate([
            favotiteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            favotiteLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            favotiteButton.centerXAnchor.constraint(equalTo: favotiteLabel.centerXAnchor, constant: 0),
            favotiteButton.bottomAnchor.constraint(equalTo: favotiteLabel.topAnchor, constant: -5),
            favotiteButton.heightAnchor.constraint(equalToConstant: 20),
            favotiteButton.widthAnchor.constraint(equalToConstant: 20),
            bookmarkLabel.leadingAnchor.constraint(equalTo: favotiteLabel.trailingAnchor, constant: 15),
            bookmarkLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            bookmarkButton.centerXAnchor.constraint(equalTo: bookmarkLabel.centerXAnchor, constant: 0),
            bookmarkButton.bottomAnchor.constraint(equalTo: bookmarkLabel.topAnchor, constant: -5),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 20),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 20),
            shareLabel.leadingAnchor.constraint(equalTo: bookmarkLabel.trailingAnchor, constant: 15),
            shareLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            shareButton.centerXAnchor.constraint(equalTo: shareLabel.centerXAnchor, constant: 0),
            shareButton.bottomAnchor.constraint(equalTo: shareLabel.topAnchor, constant: -5),
            shareButton.heightAnchor.constraint(equalToConstant: 20),
            shareButton.widthAnchor.constraint(equalToConstant: 20),
            moreLabel.leadingAnchor.constraint(equalTo: shareLabel.trailingAnchor, constant: 15),
            moreLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            moreButton.centerXAnchor.constraint(equalTo: moreLabel.centerXAnchor, constant: 0),
            moreButton.bottomAnchor.constraint(equalTo: moreLabel.topAnchor, constant: -10),
            moreButton.heightAnchor.constraint(equalToConstant: 7.5),
            moreButton.widthAnchor.constraint(equalToConstant: 20),

        ])
        return view
    }()

    // MARK: - Property

    private let dateFormater = DateFormatter()
    var data: Results?
    var genre = ""
    private var actors: [Cast] = []

    // MARK: - Lyfe Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(moviePosterImageView)
        view.addSubview(scrollView)
        dateFormater.dateFormat = "yyyy-MM-dd"
        setupUI(data: data)
        configureConstraint()
    }

    // MARK: Private Methods

    private func setupUI(data: Results?) {
        guard let dataPosterImage = data?.posterPath,
              let dataRating = data?.voteAverage, let dataReleaseDate = data?.releaseDate, let movieId = data?.id
        else { return }
        DispatchQueue.main.async {
            guard let urlImage = URL(string: "https://image.tmdb.org/t/p/w500" + dataPosterImage) else { return }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlImage) { data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self.moviePosterImageView.image = image
                }
            }
            task.resume()
        }
        DispatchQueue.main.async {
            guard let url =
                URL(
                    string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=d9e4494907230d135d6f6fd47beca82e&append_to_response=videos&language=ru"
                )
            else { return }
            let session = URLSession.shared
            let decoder = JSONDecoder()
            let task = session.dataTask(with: url) { data, _, error in
                if error == nil, let parseData = data {
                    guard let genre = try? decoder.decode(MovieGenreNetwork.self, from: parseData) else { return }
                    self.genres = ""
                    for genre in genre.genres {
                        if self.genres.isEmpty {
                            self.genres += genre.name
                        } else {
                            self.genres += ", " + genre.name
                        }
                        DispatchQueue.main.async {
                            let date = self.dateFormater.date(from: dataReleaseDate)
                            self.dateFormater.dateFormat = "yyyy"
                            self.genreLabel.text = self.dateFormater.string(from: date ?? Date()) + ", " + self.genres
                        }
                    }
                }
            }
            task.resume()
        }
        movieNameLabel.text = data?.title
        ratingLabel.text = String(dataRating)
        descriptionLabel.text = data?.overview
        ratingLabel.textColor = {
            guard let rating = Double(ratingLabel.text ?? "") else { return .lightGray }
            switch rating {
            case 5 ..< 7: return .lightGray
            case 7 ... 10: return .green
            default: return .systemRed
            }
        }()
        DispatchQueue.main.async {
            guard let url =
                URL(
                    string: "https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=d9e4494907230d135d6f6fd47beca82e"
                )
            else { return }
            let session = URLSession.shared
            let decoder = JSONDecoder()
            let task = session.dataTask(with: url) { data, _, error in
                if error == nil, let parseData = data {
                    guard let desription = try? decoder.decode(MoviewDescriptionNetwork.self, from: parseData)
                    else { return }
                    DispatchQueue.main.async {
                        self.actors = desription.cast
                        self.actorCollectionView.reloadData()
                    }
                }
            }
            task.resume()
        }
    }

    private func configureConstraint() {
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalTo: viewBack.topAnchor, constant: 25),
            movieNameLabel.widthAnchor.constraint(equalToConstant: viewBack.frame.width - 100),
            movieNameLabel.centerXAnchor.constraint(equalTo: viewBack.centerXAnchor, constant: 0),
            ratingLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 15),
            ratingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            genreLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 5),
            genreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            seeMovieButton.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10),
            seeMovieButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            seeMovieButton.heightAnchor.constraint(equalToConstant: 70),
            seeMovieButton.widthAnchor.constraint(equalToConstant: 250),
            tabBarActionView.topAnchor.constraint(equalTo: seeMovieButton.bottomAnchor, constant: 70),
            tabBarActionView.leadingAnchor.constraint(equalTo: viewBack.leadingAnchor, constant: 60),
            actorsLabel.topAnchor.constraint(equalTo: tabBarActionView.bottomAnchor, constant: 20),
            actorsLabel.leadingAnchor.constraint(equalTo: viewBack.leadingAnchor, constant: 20),
            actorCollectionView.topAnchor.constraint(equalTo: tabBarActionView.bottomAnchor, constant: 50),
            actorCollectionView.leadingAnchor.constraint(equalTo: viewBack.leadingAnchor, constant: 0),
            actorCollectionView.trailingAnchor.constraint(equalTo: viewBack.trailingAnchor, constant: 0),
            actorCollectionView.heightAnchor.constraint(equalToConstant: 300),
            actorCollectionView.widthAnchor.constraint(equalToConstant: viewBack.frame.width),
            descriptionTitleLabel.topAnchor.constraint(equalTo: actorCollectionView.bottomAnchor, constant: 0),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: viewBack.leadingAnchor, constant: 20),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: viewBack.leadingAnchor, constant: 20),
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
            .dequeueReusableCell(withReuseIdentifier: "ActorCell", for: indexPath) as? ActorCollectionViewCell
        else { return UICollectionViewCell() }
        let actor = actors[indexPath.row]
        let actors = Actor(
            actorImageName: actor.profilePath ?? "",
            actorName: actor.name,
            actorRoleName: actor.character
        )
        cell.setupUI(actror: actors)
        return cell
    }
}
