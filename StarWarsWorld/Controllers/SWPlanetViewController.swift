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
    
    var currentPlanet: SWPlanet?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupInfo()
    }
    
    func setupInfo() {
        self.navigationItem.title = self.currentPlanet?.name
        self.populationLabel.text = "Population " + (self.currentPlanet?.population)!
        self.climateLabel.text = "Climate " + (self.currentPlanet?.climate)!
        self.diameterLabel.text = "Diameter " + (self.currentPlanet?.diameter)!
        self.terrainLabel.text = "Terrain " + (self.currentPlanet?.terrain)!
    }
}
