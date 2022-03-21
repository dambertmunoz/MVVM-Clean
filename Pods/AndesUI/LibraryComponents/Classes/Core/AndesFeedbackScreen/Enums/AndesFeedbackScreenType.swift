//
//  AndesFeedbackScreenType.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 17/08/2021.
//

import Foundation

enum AndesFeedbackScreenType: Int, AndesEnumStringConvertible {
    case simple
    case congrats

    public static func keyFor(_ value: AndesFeedbackScreenType) -> String {
        switch value {
        case .simple: return "SIMPLE"
        case .congrats: return "CONGRATS"
        }
    }
}
