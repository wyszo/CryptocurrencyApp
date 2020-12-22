//
//  StoryboardExtensions.swift
//  CryptocurrencyApp
//
//  Copyright © 2020 Thomas Wyszomirski. All rights reserved.
//

import UIKit

enum StoryboardError: Error {
    case ViewControllerTypeMismatch
}

extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func viewController<T>(ofType type: T.Type) throws -> T {
        guard let controller = viewController(named: String(describing: type)) as? T else {
            throw StoryboardError.ViewControllerTypeMismatch
        }
        return controller
    }
    
    private func viewController(named viewControllerName: String) -> UIViewController {
        
        /**
         * Note that this code while it simplifies view controller instantiation, it makes
         *  an assumption, that the storyboard view controller identifier is going to be
         *  the same as the class name.
         */
        return self.instantiateViewController(identifier: viewControllerName)
    }
}
