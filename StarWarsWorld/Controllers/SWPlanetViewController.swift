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
        self.navigationItem.title = planet.name
        self.populationLabel.text = "Population " + planet.population
        self.climateLabel.text = "Climate " + planet.climate
        self.diameterLabel.text = "Diameter " + planet.diameter
        self.terrainLabel.text = "Terrain " + planet.terrain
    }
}
