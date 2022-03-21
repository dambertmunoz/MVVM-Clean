//
//  DefaultsLinearProgress.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 8/09/21.
//

import Foundation

@objc(DefaultsLinearProgress) public class DefaultsLinearProgress: NSObject {
    @objc static public let trackTint: UIColor = UIColor.Andes.gray100
    @objc static public let indicatorTint: UIColor = UIColor.Andes.blueML500
    @objc static public let size: AndesLinearProgressIndicatorSize = .small
    @objc static public let splitSize: Int = 0
    @objc static public let cornerRadius: Int = 0
    @objc static public let allRoundedCorner: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    @objc static public let topBottomRightRoundedCorner: CACornerMask = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    @objc static public let topBottomLeftRoundedCorner: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    @objc static public let isSplit: Bool = false
    @objc static public let numberOfSteps: Int = 10
    @objc static public let minNumberOfSteps = 1
    @objc static public let maxNumberOfSteps = 20
    @objc static public let stepInitial: Int = 0
    @objc static public let stepOne: Int = 1
    @objc static public let stepTwo: Int = 2
}
