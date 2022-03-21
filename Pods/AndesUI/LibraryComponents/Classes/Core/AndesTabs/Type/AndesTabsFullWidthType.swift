//
//  
//  AndesTabsTypeSuccess.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 21/07/21.
//
//

import Foundation

class AndesTabsFullWidthType: AndesTabsTypeProtocol {
    var currentSelection: Int = 0
    var distribution: UIStackView.Distribution = .fillEqually
    var textAlignment: NSTextAlignment = .left
    var widthPriority: UILayoutPriority = .defaultHigh
    var fullWidthTab: Bool = true
}
