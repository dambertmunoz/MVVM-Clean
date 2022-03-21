//
//  StoryBoarded.swift
//  ExampleViewController
//
//  Created by Dambert Louis Munoz Santillana on 10/03/22.
//

import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension UIViewController {

    // By Storyboard
    static func instantiate() -> Self {
        // this pulls out "MyApp.MyViewController"
        let fullName = NSStringFromClass(self)

        // this splits by the dot and uses everything after, giving "MyViewController"
        let className = fullName.components(separatedBy: ".")[1]

        // load our storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // instantiate a view controller with that identifier, and force cast as the type that was requested
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }

    // By XIB
    static func genericInstance<T: UIViewController>() -> T {
        return T.init(nibName: String(describing: self), bundle: Bundle(for: self))
    }

    static func instance() -> Self {
        return genericInstance()
    }
}
