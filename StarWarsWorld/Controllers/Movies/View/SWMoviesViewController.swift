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
    private var movies: [SWMovie] = []
    private var interactor: SWMoviesInteractor?

    func setup(interactor: SWMoviesInteractor) {
        self.interactor = interactor
        self.interactor?.fetchMovies()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        movieTable.delegate = self
        movieTable.dataSource = self
        movieTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

}

extension SWMoviesViewController: SWMoviesDisplayLogic {
    
    func displayMovies(movies: [SWMovie]) {
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
       
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SWMovieInfoViewController") as! SWMovieInfoViewController
        vc.movie = movies[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

