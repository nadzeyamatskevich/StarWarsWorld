//
//  ViewController.swift
//  StarWarsWorld
//
//  Created by мак on 07.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import UIKit

class SWMoviesViewController: UIViewController,  UITableViewDelegate {
   
    @IBOutlet weak var movieTable: UITableView!

    private var movies: [SWMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        self.movieTable.delegate = self
        self.movieTable.dataSource = self
        self.movieTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func getData() {
        SWSwapiManager.getMovies(success: { movies in
            self.movies = movies
            self.movieTable.reloadData()
        }, fail: { error in
            print("ERROR: ", error)
        })
    }
}

// MARK: - UITableViewDataSource
extension SWMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
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
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

