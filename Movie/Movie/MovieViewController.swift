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
        return segment
    }()

    private lazy var movieTableView: UITableView = {
        let table = UITableView(frame: CGRect(), style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

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
        40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdCell", for: indexPath) as? AdViewCell
            cell?.setup(name: "banner")

            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as? MovieViewCell
            cell?.label.text = "\(indexPath.row)"
            return cell ?? UITableViewCell()
        }
    }
}
