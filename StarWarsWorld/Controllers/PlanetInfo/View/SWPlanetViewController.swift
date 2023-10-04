//
//  SWPlanetViewController.swift
//  StarWarsWorld
//
//  Created by мак on 08.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import UIKit

protocol SWPlanetInfoDisplayLogic: class {
    func displayPlanetInfo(with planet: SWPlanet)
}

class SWPlanetViewController: UIViewController {

    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var climateLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var terrainLabel: UILabel!

    private var interactor: SWPlanetInfoIneractorLogic?

    func setup(interactor: SWPlanetInfoIneractorLogic) {
        self.interactor = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.showPlanetInfo()
    }

}

extension SWPlanetViewController: SWPlanetInfoDisplayLogic {
    
    func displayPlanetInfo(with planet: SWPlanet) {
        navigationItem.title = planet.name
        populationLabel.text = "Population: " + planet.population
        climateLabel.text = "Climate: " + planet.climate
        diameterLabel.text = "Diameter: " + planet.diameter
        terrainLabel.text = "Terrain: " + planet.terrain
    }

}
