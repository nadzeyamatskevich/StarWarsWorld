//
//  SWCharactersRouter.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-05.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import UIKit

protocol SWCharactersRouterLogic {
    func showCharacterInfo(for character: SWCharacter)
}

class SWCharactersRouter {

    weak var source: UIViewController?

    init(source: UIViewController) {
        self.source = source
    }

}

extension SWCharactersRouter: SWCharactersRouterLogic {

    func showCharacterInfo(for character: SWCharacter) {
        let scene = SWCharacterInfoBuilder.build(with: character)
        source?.navigationController?.pushViewController(scene, animated: true)
    }

}
