//
//  SWMoviesRouter.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-02.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import UIKit

protocol SWMoviesRouterLogic {
    func showMovieInfo(for movie: SWMovie)
}

class SWMoviesRouter {

    weak var source: UIViewController?

    init(source: UIViewController) {
        self.source = source
    }

}

extension SWMoviesRouter: SWMoviesRouterLogic {

    func showMovieInfo(for movie: SWMovie) {
        let scene = SWMovieInfoBuilder().build()
        source?.navigationController?.pushViewController(scene, animated: true)
    }

}

