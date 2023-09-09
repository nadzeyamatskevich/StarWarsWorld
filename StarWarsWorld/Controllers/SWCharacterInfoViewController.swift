//
//  SWCharacterInfoViewController.swift
//  StarWarsWorld
//
//  Created by мак on 08.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import UIKit

class SWCharacterInfoViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var homeworldLabel: UILabel!
    @IBOutlet weak var speciesTable: UITableView!
    @IBOutlet weak var filmsTable: UITableView!

    var movieArray: [String] = []
    var speciesArray: [String] = []
    
    var currentCharacter: SWCharacter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCharacterInfo()
        setupHomeworldTap()
        setupMovieTable()
        setupSpeciesTable()
        
        self.speciesTable.delegate = self
        self.speciesTable.dataSource = self
        self.speciesTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.filmsTable.delegate = self
        self.filmsTable.dataSource = self
        self.filmsTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupCharacterInfo() {
        let planetPrimaryKey = (currentCharacter?.homeworld)!
        //let currentPlanet = realm.object(ofType: SWPlanet.self, forPrimaryKey: planetPrimaryKey)
        
        self.navigationItem.title = currentCharacter?.name
        self.genderLabel.text = "Gender \((currentCharacter?.gender)!)"
        self.birthLabel.text = "Birth date " + (currentCharacter?.birth_year)!
        //self.homeworldLabel.text = "Homeworld " + (currentPlanet?.name)!
    }
    
    func setupHomeworldTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        homeworldLabel.addGestureRecognizer(tap)
    }
    
    func setupMovieTable() {
        /*for movie in (currentCharacter?.films)! {
            let moviePrimaryKey = movie
            let currentMovie = realm.object(ofType: SWMovie.self, forPrimaryKey: moviePrimaryKey)
            self.movieArray.append((currentMovie?.title)!)
        }
        self.filmsTable.reloadData()*/
    }
    
    func setupSpeciesTable() {
        /*for species in (currentCharacter?.species)! {
            let speciesPrimaryKey = species
            let currentSpecies = realm.object(ofType: SWSpecies.self, forPrimaryKey: speciesPrimaryKey)
            self.speciesArray.append((currentSpecies?.name)!)
        }
        self.speciesTable.reloadData()*/
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SWPlanetViewController") as! SWPlanetViewController
        vc.planetPrimaryKey = (self.currentCharacter?.homeworld)!
        navigationController?.pushViewController(vc, animated: true)*/
    }
}

// MARK: - UITableViewDataSource
extension SWCharacterInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.speciesTable {
            return self.speciesArray.count
        } else {
            return self.movieArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.speciesTable {
            let cell:UITableViewCell = (self.speciesTable.dequeueReusableCell(withIdentifier: "cell"))!
            
            let char = self.speciesArray[indexPath.row]
            cell.textLabel?.text = char
            cell.backgroundColor = UIColor.darkGray
            cell.textLabel?.textColor = UIColor.white
            
            return cell
        } else {
            let cell:UITableViewCell = (self.filmsTable.dequeueReusableCell(withIdentifier: "cell"))!
            let char = self.movieArray[indexPath.row]
            cell.textLabel?.text = char
            cell.backgroundColor = UIColor.darkGray
            cell.textLabel?.textColor = UIColor.white
            
            return cell
        }
    }
}
