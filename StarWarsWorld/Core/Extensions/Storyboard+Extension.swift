//
//  Storyboard+Extension.swift
//  StarWarsWorld
//
//  Created by Nadzeya Savitskaya on 2023-10-02.
//  Copyright © 2023 nadzeyamatskevich. All rights reserved.
//

import UIKit

extension UIStoryboard {

    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }

}
