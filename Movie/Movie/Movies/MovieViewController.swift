// MovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
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
    private let dateFormater = DateFormatter()
    private var movie: Movies?
    private var genres = ""

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
        dateFormater.dateFormat = "yyyy-MM-dd"
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

    private func getMovieGenre(data: Results?) {
        guard let movieId = data?.id else { return }
        guard let url =
            URL(
                string: "https://api.themoviedb.org/3/movie/\(movieId)?api_key=d9e4494907230d135d6f6fd47beca82e&append_to_response=videos&language=ru"
            )
        else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, _, error in
            if error == nil, let parseData = data {
                guard let genre = try? JSONDecoder().decode(MovieGenreNetwork.self, from: parseData) else { return }
                self.genres = ""
                for genre in genre.genres {
                    if self.genres.isEmpty {
                        self.genres += genre.name
                    } else {
                        self.genres += ", " + genre.name
                    }
                }
            }
        }

        task.resume()
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
            cell?.setup(name: "adsLogo")
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieViewCell
            cell?.selectionStyle = .none

            let date = dateFormater.date(from: data?.releaseDate ?? "")
            dateFormater.dateFormat = "dd MMM yyyy"
            getMovieGenre(data: data)

            let movie = Movies(
                movieImageName: data?.posterPath ?? "",
                movieGenreName: genres,
                movieNameText: data?.title ?? "Non",
                movieDateText: dateFormater.string(from: date ?? Date()),
                ratingValue: data?.voteAverage ?? 0
            )
            self.movie = movie
            cell?.setupView(movie: movie)
            return cell ?? UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MoviesDescriptionViewController()
        let data = dataSource?.results[indexPath.row]
        vc.data = data
        navigationController?.pushViewController(vc, animated: true)
    }
}
