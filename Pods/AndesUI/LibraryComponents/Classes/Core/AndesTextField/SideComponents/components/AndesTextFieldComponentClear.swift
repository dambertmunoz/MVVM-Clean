//
//  AndesTextFieldComponentClear.swift
//  AndesUI
//
//  Created by Nicolas Rostan Talasimov on 4/1/20.
//

import Foundation

@objc public class AndesTextFieldComponentClear: NSObject, AndesTextFieldRightComponent {
    public private(set) var visibility: AndesTextFieldComponentVisibility = .whenNotEmpty
    public private(set) var reloadPolicy: AndesTextFieldComponentReloadPolicy = .always

    let clearIcon = AndesIcons.close16
    let iconColor = AndesStyleSheetManager.styleSheet.textColorSecondary
}
