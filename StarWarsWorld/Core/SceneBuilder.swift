//
//  SceneBuilder.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-02.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import Foundation
import UIKit

protocol MoviesSceneBuilder {
    func build() -> UIViewController
}

protocol MovieInfoSceneBuilder {
    func build(with movie: SWMovie) -> UIViewController
}
