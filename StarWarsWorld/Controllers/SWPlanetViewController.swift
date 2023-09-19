//
//  SWPlanetViewController.swift
//  StarWarsWorld
//
//  Created by мак on 08.07.2018.
//  Copyright © 2018 мак. All rights reserved.
//

import UIKit

class SWPlanetViewController: UIViewController {

    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var climateLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var terrainLabel: UILabel!
    
    var currentPlanetUrl: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
    }

    func getData() {
        guard let url = self.currentPlanetUrl else { return }
        SWSwapiManager.getPlanet(pageURL: url, success: { planet in
            self.setupInfo(with: planet)
        }, fail: { error in
            print("Error: \(error.localizedDescription)")
        })
    }
    
    func setupInfo(with planet: SWPlanet) {
        navigationItem.title = planet.name
        populationLabel.text = "Population " + planet.population
        climateLabel.text = "Climate " + planet.climate
        diameterLabel.text = "Diameter " + planet.diameter
        terrainLabel.text = "Terrain " + planet.terrain
    }
}
