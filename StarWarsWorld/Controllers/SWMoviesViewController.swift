//
//  ViewController.swift
//  StarWarsWorld
//
//  Created by мак on 07.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import UIKit
import RealmSwift

class SWMoviesViewController: UIViewController,  UITableViewDelegate {
   
    @IBOutlet weak var movieTable: UITableView!

    let realm = try! Realm()
    var movies: Results<SWMovie>?
    var planets: Results<SWPlanet>?
    var species: Results<SWSpecies>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDataBase()
        
        self.movieTable.delegate = self
        self.movieTable.dataSource = self
        self.movieTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupDataBase (){
        self.movies = self.realm.objects(SWMovie.self)
        self.planets = self.realm.objects(SWPlanet.self)
        self.species = self.realm.objects(SWSpecies.self)
        
        SWSwapiManager.getMovies( success: {
            self.movies = self.realm.objects(SWMovie.self)
            self.movieTable.reloadData()
        }, fail: { error in
            print("ERROR: ", error)
        })
        
        SWSwapiManager.getPlanets(page: "", success: {
            self.planets = self.realm.objects(SWPlanet.self)
        }, fail: { error in
            print("ERROR: ", error)
        })
        
        SWSwapiManager.getSpecies(page: "", success: {
            self.species = self.realm.objects(SWSpecies.self)
        }, fail: { error in
            print("ERROR: ", error)
        })
    }
}

// MARK: - UITableViewDataSource
extension SWMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.movieTable.dequeueReusableCell(withIdentifier: "cell"))!
        
        let movie = movies?[indexPath.row]
        cell.backgroundColor = UIColor.darkGray
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = movie?.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SWMovieInfoViewController") as! SWMovieInfoViewController
        vc.numberOfMovie = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}

