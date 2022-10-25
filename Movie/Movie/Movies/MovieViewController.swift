// MovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

///
final class MovieViewController: UIViewController {
    // MARK: - Private Visual Component

    private lazy var filtherMovieSegmentControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Популярное", "Ожидаемые", "Лучшие"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(changeSegmentAction), for: .valueChanged)
        return segment
    }()

    private lazy var movieTableView: UITableView = {
        let table = UITableView(frame: CGRect(), style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    // MARK: Proivate Property

    private var networkManager = NetworkManager()
    private var dataSource: MoviesNetwork?

    // MARK: - Lyfe Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: Private Methods

    private func setupUI() {
        title = "Фильмы"
        view.addSubview(filtherMovieSegmentControl)
        view.addSubview(movieTableView)
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.register(MovieViewCell.self, forCellReuseIdentifier: "MovieCell")
        movieTableView.register(AdViewCell.self, forCellReuseIdentifier: "AdCell")
        addContraint()
        getMovies(genre: "popular")
    }

    @objc private func changeSegmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            getMovies(genre: "popular")
        case 1:
            getMovies(genre: "upcoming")
        case 2:
            getMovies(genre: "people")
        default:
            getMovies(genre: "popular")
        }
    }

    private func getMovies(genre: String) {
        networkManager.getMovies(genre: genre) { [weak self] result in
            switch result {
            case let .success(movies):
                self?.dataSource = movies
                DispatchQueue.main.async {
                    self?.movieTableView.reloadData()
                }
            case let .failure(error):
                print(error)
            }
        }
    }

    private func addContraint() {
        NSLayoutConstraint.activate([
            filtherMovieSegmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            filtherMovieSegmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            filtherMovieSegmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            movieTableView.topAnchor.constraint(equalTo: filtherMovieSegmentControl.bottomAnchor, constant: 20),
            movieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            movieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (dataSource?.results.count ?? 0) + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataSource?.results[indexPath.row]
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdCell", for: indexPath) as? AdViewCell
            cell?.setup(name: "banner")

            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieViewCell

            let movie = Movies(
                movieImageName: data?.posterPath ?? "",
                movieNameText: data?.title ?? "Non",
                movieDescriptionText: data?.releaseDate ?? "",
                ratingValue: data?.voteAverage ?? 0
            )

            cell?.setupView(movie: movie)
            return cell ?? UITableViewCell()
        }
    }
}
