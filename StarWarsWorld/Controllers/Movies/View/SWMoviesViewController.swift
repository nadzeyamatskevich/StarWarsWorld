//
//  ViewController.swift
//  StarWarsWorld
//
//  Created by мак on 07.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import UIKit

protocol SWMoviesDisplayLogic: class {
    func displayMovies(movies: [SWMovie])
    func displayEmptyList()
}

class SWMoviesViewController: UIViewController, UITableViewDelegate {
   
    // - UI
    @IBOutlet weak var movieTable: UITableView!

    // - Data

    // TODO: move movies property to table view manager
    private var movies: [SWMovie] = []
    private var interactor: SWMoviesInteractor?

    func setup(interactor: SWMoviesInteractor) {
        self.interactor = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.fetchMovies()
        setupTableView()
    }

    private func setupTableView() {
        movieTable.delegate = self
        movieTable.dataSource = self
        movieTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

}

extension SWMoviesViewController: SWMoviesDisplayLogic {
    
    func displayMovies(movies: [SWMovie]) {
        // TODO: reload table view via call table view manager
        self.movies = movies
        DispatchQueue.main.async {
            self.movieTable.reloadData()
        }
    }
    
    func displayEmptyList() {
        //TODO: create empty state
        movies = []
        DispatchQueue.main.async {
            self.movieTable.reloadData()
        }
    }

}

// MARK: - UITableViewDataSource
// TODO: move to table view manager
extension SWMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = movieTable.dequeueReusableCell(withIdentifier: "cell")!
        
        let movie = movies[indexPath.row]
        cell.backgroundColor = UIColor.darkGray
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = movie.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       //TODO: move to router
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SWMovieInfoViewController") as! SWMovieInfoViewController
        vc.movie = movies[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}
