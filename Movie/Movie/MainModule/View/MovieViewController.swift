// MovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import SwiftyJSON
import UIKit

/// Главная страница со списком фильмов
final class MovieViewController: UIViewController {
    // MARK: Private Costants

    private enum Constants {
        static let segmentControlItems = ["Популярное", "Ожидаемые", "Лучшие"]
        static let movieTitleText = "Фильмы"
        static let movieCellIdentifier = "MovieCell"
        static let adCellIdentifier = "AdCell"
        static let genres = ["popular", "upcoming"]
        static let resultDateFormat = "yyyy-MM-dd"
        static let editDateFormat = "dd MMM yyyy"
        static let adImageName = "adsLogo"
        static let apiRequestURL = "https://api.themoviedb.org/3/movie/"
        static let apiKeyURL = "api_key=d9e4494907230d135d6f6fd47beca82e"
        static let apiLanguageURL = "language=ru"
        static let appendResponseVideosURL = "append_to_response=videos"
    }

    // MARK: - Private Visual Component

    private lazy var filtherMovieSegmentControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: Constants.segmentControlItems)
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(changeSegmentAction), for: .valueChanged)
        return segment
    }()

    private let movieTableView: UITableView = {
        let table = UITableView(frame: CGRect(), style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    // MARK: - Private Property

    private var networkManager = NetworkManager()

    // MARK: Public Property

    var presenter: MainViewPresenterProtocol!

    // MARK: - Lyfe Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: Private Methods

    private func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        title = Constants.movieTitleText
        view.addSubview(filtherMovieSegmentControl)
        getMovies(genre: .popular)
        setupRefreshControl()
        setupMovieTableView()
    }

    private func setupMovieTableView() {
        view.addSubview(movieTableView)
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.register(MovieViewCell.self, forCellReuseIdentifier: Constants.movieCellIdentifier)
        addContraint()
    }

    private func setupRefreshControl() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshPageAction), for: .valueChanged)
        movieTableView.refreshControl = refresh
    }

    private func getMovies(genre: MovieGenre) {
        presenter.fetchMovie(genre: genre)
    }

    private func addContraint() {
        NSLayoutConstraint.activate([
            filtherMovieSegmentControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            filtherMovieSegmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            filtherMovieSegmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            movieTableView.topAnchor.constraint(equalTo: filtherMovieSegmentControl.bottomAnchor, constant: 20),
            movieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            movieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }

    @objc private func refreshPageAction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.movieTableView.refreshControl?.beginRefreshing()
            self.movieTableView.reloadData()
            self.movieTableView.refreshControl?.endRefreshing()
        }
    }

    @objc private func changeSegmentAction(_ sender: UISegmentedControl) {
        presenter.updateSegmentControl(page: sender.selectedSegmentIndex)
    }
}

// MARK: - UITableViewDataSource

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.movieCellIdentifier,
            for: indexPath
        ) as? MovieViewCell
        cell?.selectionStyle = .none
        cell?.setupView(movie: presenter.movies[indexPath.row], networkService: networkManager)
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = presenter.movies[indexPath.row].id
        presenter.showDetail(id: id)
    }
}

// MARK: - MainViewProtocol

extension MovieViewController: MainViewProtocol {
    func success() {
        movieTableView.reloadData()
    }

    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
