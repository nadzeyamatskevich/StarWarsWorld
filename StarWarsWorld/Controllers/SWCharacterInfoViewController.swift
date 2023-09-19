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
        
        speciesTable.delegate = self
        speciesTable.dataSource = self
        speciesTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        filmsTable.delegate = self
        filmsTable.dataSource = self
        filmsTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupCharacterInfo() {
        guard let person = currentCharacter else { return }

        navigationItem.title = person.name
        genderLabel.text = "Gender" + person.gender
        birthLabel.text = "Birth date " + person.birth_year
        homeworldLabel.text = "Homeworld " + person.homeworld
    }
    
    func setupHomeworldTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        homeworldLabel.addGestureRecognizer(tap)
    }
    
    func setupMovieTable() {
        guard let person = currentCharacter else { return }

        for movie in person.films {
            //let moviePrimaryKey = movie
            //let currentMovie = realm.object(ofType: SWMovie.self, forPrimaryKey: moviePrimaryKey)
            //self.movieArray.append((currentMovie?.title)!)
        }
        filmsTable.reloadData()
    }
    
    func setupSpeciesTable() {
        guard let person = currentCharacter else { return }

        for species in person.species {
            //let speciesPrimaryKey = species
            //let currentSpecies =
            //self.speciesArray.append((currentSpecies?.name)!)
        }
        speciesTable.reloadData()
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        guard let person = currentCharacter else { return }

        //TODO: create enum for storyboards
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SWPlanetViewController") as! SWPlanetViewController
        vc.currentPlanetUrl = URL(string: person.homeworld)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension SWCharacterInfoViewController: UITableViewDataSource {
    //TODO: rewrite this (delete table view for spechies)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let person = currentCharacter else { return 0 }

        if tableView == self.speciesTable {
            return person.species.count
        } else {
            return person.films.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.speciesTable {
            let cell:UITableViewCell = (self.speciesTable.dequeueReusableCell(withIdentifier: "cell"))!
            guard let person = currentCharacter else { return cell }

            let char = person.species[indexPath.row]
            cell.textLabel?.text = char
            cell.backgroundColor = UIColor.darkGray
            cell.textLabel?.textColor = UIColor.white
            
            return cell
        } else {
            let cell:UITableViewCell = (self.filmsTable.dequeueReusableCell(withIdentifier: "cell"))!
            guard let person = currentCharacter else { return cell }

            let char = person.films[indexPath.row]
            cell.textLabel?.text = char
            cell.backgroundColor = UIColor.darkGray
            cell.textLabel?.textColor = UIColor.white
            
            return cell
        }
    }
}
