// MoviesDescriptionViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

final class MoviesDescriptionViewController: UIViewController {
    lazy var moviePosterImageView: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 400, height: 500))

        return image
    }()

    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: view.bounds)
        scroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 2)
        scroll.addSubview(viewBack)
        return scroll
    }()

    lazy var viewBack: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 300, width: 400, height: 1404))
        view.backgroundColor = .black
        view.addSubview(movieNameLabel)
        view.addSubview(ratingLabel)
        view.addSubview(genreLabel)
        view.addSubview(seeMovieButton)
        view.addSubview(tabBarActionView)
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

    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "7.8"
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()

    let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2017, триллер, драмма"
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
              let dataRating = data?.voteAverage, let dataReleaseDate = data?.releaseDate
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
        movieNameLabel.text = data?.title
        ratingLabel.text = String(dataRating)
        let date = dateFormater.date(from: dataReleaseDate)
        dateFormater.dateFormat = "yyyy"
        genreLabel.text = dateFormater.string(from: date ?? Date()) + ", триллер, драмма"
    }

    private func configureConstraint() {
        NSLayoutConstraint.activate([
            movieNameLabel.topAnchor.constraint(equalTo: viewBack.topAnchor, constant: 25),
            movieNameLabel.widthAnchor.constraint(equalToConstant: viewBack.frame.width - 100),
            movieNameLabel.centerXAnchor.constraint(equalTo: viewBack.centerXAnchor, constant: 0),
            ratingLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 30),
            ratingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            genreLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 5),
            genreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            seeMovieButton.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10),
            seeMovieButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            seeMovieButton.heightAnchor.constraint(equalToConstant: 70),
            seeMovieButton.widthAnchor.constraint(equalToConstant: 250),
            tabBarActionView.topAnchor.constraint(equalTo: seeMovieButton.bottomAnchor, constant: 70),
            tabBarActionView.leadingAnchor.constraint(equalTo: viewBack.leadingAnchor, constant: 60)
        ])
    }
}
