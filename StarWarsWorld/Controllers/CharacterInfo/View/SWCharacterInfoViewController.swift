//
//  SWCharacterInfoViewController.swift
//  StarWarsWorld
//
//  Created by мак on 08.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import UIKit

protocol SWCharacterInfoDisplayLogic: class {
    func displayCharacterInfo(character: SWCharacter)
    func displayProvided(species: String)
    func displayDefaultSpecies(with error: Error?)
    func displayProvided(homeworld: SWPlanet)
    func displayDefaultHomeworld(with error: Error?)
}

class SWCharacterInfoViewController: UIViewController {

    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var homeworldLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var filmsTable: UITableView!

    var currentCharacter: SWCharacter?
    var homeworld: SWPlanet?

    private var interactor: SWCharacterInfoInteractorLogic?
    private var router: SWCharacterInfoRouterLogic?

    func setup(interactor: SWCharacterInfoInteractorLogic) {
        self.interactor = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        router = SWCharacterInfoRouter(source: self)

        interactor?.setUpCharacter()
        setupHomeworldTap()
        setupMovieTable()

        filmsTable.delegate = self
        filmsTable.dataSource = self
        filmsTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        guard let character = currentCharacter else { return }
        interactor?.fetchSpeciesIfProvided(for: character)
        interactor?.fetchHomeworldIfProvided(for: character)
    }

    func setupHomeworldTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        homeworldLabel.addGestureRecognizer(tap)
    }
    
    func setupMovieTable() {
        //TODO: make requests for movie names
        guard let person = currentCharacter else { return }

        for movie in person.films {
            //let moviePrimaryKey = movie
            //let currentMovie = realm.object(ofType: SWMovie.self, forPrimaryKey: moviePrimaryKey)
            //self.movieArray.append((currentMovie?.title)!)
        }
        //filmsTable.reloadData()
    }

    @objc func tapFunction(sender:UITapGestureRecognizer) {
        guard let homeworld = self.homeworld else { return }

        router?.showPlanet(for: homeworld)
    }
}

extension SWCharacterInfoViewController: SWCharacterInfoDisplayLogic {

    func displayProvided(species: String) {
        speciesLabel.text = "Species: " + species
    }

    func displayDefaultSpecies(with error: Error?) {
        speciesLabel.text = "Species: Human"
    }

    func displayProvided(homeworld: SWPlanet) {
        self.homeworld = homeworld
        homeworldLabel.text = "Homeworld: " + homeworld.name
    }

    func displayDefaultHomeworld(with error: Error?) {
        homeworldLabel.text = "Homeworld: do not provided"
    }

    func displayCharacterInfo(character: SWCharacter) {
        currentCharacter = character
        navigationItem.title = character.name
        genderLabel.text = "Gender: " + character.gender
        birthLabel.text = "Birth date: " + character.birth_year
        homeworldLabel.text = "Homeworld: loading"
        speciesLabel.text = "Species: loading"
    }



}

// MARK: - UITableViewDataSource
extension SWCharacterInfoViewController: UITableViewDataSource, UITableViewDelegate {
    //TODO: rewrite this (delete table view for spechies)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let person = currentCharacter else { return 0 }
        return person.films.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell = (self.filmsTable.dequeueReusableCell(withIdentifier: "cell"))!
        guard let person = currentCharacter else { return cell }

        let char = person.films[indexPath.row]
        cell.textLabel?.text = char
        cell.backgroundColor = UIColor.darkGray
        cell.textLabel?.textColor = UIColor.white

        return cell
    }
}
