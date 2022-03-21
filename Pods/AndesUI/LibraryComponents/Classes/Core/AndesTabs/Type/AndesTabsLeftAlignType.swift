//
//  
//  AndesTabsTypeError.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 21/07/21.
//
//

import Foundation

class AndesTabsLeftAlignType: AndesTabsTypeProtocol {
    var textAlignment: NSTextAlignment = .center
    var currentSelection: Int = 0
    var distribution: UIStackView.Distribution = .fill
    var widthPriority: UILayoutPriority = .defaultLow
    var fullWidthTab: Bool = false
}
