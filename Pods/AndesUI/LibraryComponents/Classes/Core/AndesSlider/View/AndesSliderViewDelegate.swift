//
//  AndesSliderViewDelegate.swift
//  AndesUI
//
//  Created by Victor Chang on 19/04/2021.
//

import Foundation

internal protocol AndesSliderViewDelegate: AnyObject {
    func onValueChanged(value: Double, sender: UISlider)
}
