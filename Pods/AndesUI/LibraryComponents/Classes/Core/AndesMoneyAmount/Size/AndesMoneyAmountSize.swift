//
//  AndesMoneyAmountSize.swift
//  AndesUI
//
//  Created by Daniel Esteban Beltran Beltran on 24/08/21.
//

import Foundation

/// Used to define the size of an AndesMoneyAmount
@objc public enum AndesMoneyAmountSize: Int, AndesEnumStringConvertible {
    case size12
    case size14
    case size16
    case size18
    case size20
    case size24
    case size28
    case size32
    case size36
    case size40
    case size44
    case size48
    case size52
    case size56
    case size60

    public static func keyFor(_ value: AndesMoneyAmountSize) -> String {
        switch value {
        case size12:
            return "12"
        case size14:
            return "14"
        case size16:
            return "16"
        case size18:
            return "18"
        case size20:
            return "20"
        case size24:
            return "24"
        case size28:
            return "28"
        case size32:
            return "32"
        case size36:
            return "36"
        case size40:
            return "40"
        case size44:
            return "44"
        case size48:
            return "48"
        case size52:
            return "52"
        case size56:
            return "56"
        case size60:
            return "60"
        }
    }

    public static func superScriptSizeFor(_ value: AndesMoneyAmountSize) -> CGFloat {
        switch value {
        case size12, .size14:
            fatalError("this size  is not valid for superscript select a higher value ")
        case size16, .size18, .size20:
            return 10
        case size24:
            return 12
        case size28:
            return 14
        case size32:
            return 16
        case size36:
            return 18
        case size40:
            return 20
        case size44:
            return 22
        case size48:
            return 24
        case size52:
            return 26
        case size56:
            return 28
        case size60:
            return 30
        }
    }
}
