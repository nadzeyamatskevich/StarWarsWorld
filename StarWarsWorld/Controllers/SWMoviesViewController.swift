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

    var movies: [SWMovie] = []
    var planets: [SWPlanet] = []
    var species: [SWSpecies] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDataBase()
        
        self.movieTable.delegate = self
        self.movieTable.dataSource = self
        self.movieTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupDataBase (){
        //self.movies = self.realm.objects(SWMovie.self)
        //self.planets = self.realm.objects(SWPlanet.self)
        //self.species = self.realm.objects(SWSpecies.self)
        
        SWSwapiManager.getMovies(success: { movies in
            self.movies = movies
            self.movieTable.reloadData()
        }, fail: { error in
            print("ERROR: ", error)
        })
        
        SWSwapiManager.getPlanets(success: { planets in
            self.planets = planets
        }, fail: { error in
            print("ERROR: ", error)
        })
        
        SWSwapiManager.getSpecies(success: { species in
            self.species = species
        }, fail: { error in
            print("ERROR: ", error)
        })
    }
}

// MARK: - UITableViewDataSource
extension SWMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.movieTable.dequeueReusableCell(withIdentifier: "cell"))!
        
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

