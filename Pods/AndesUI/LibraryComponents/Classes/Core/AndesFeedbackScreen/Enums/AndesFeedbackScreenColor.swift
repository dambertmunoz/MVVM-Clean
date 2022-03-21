//
//  AndesFeedbackScreenColor.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 17/08/2021.
//

import Foundation

@objc public enum AndesFeedbackScreenColor: Int, AndesEnumStringConvertible {
    var colorType: AndesBadgeIconType {
        switch self {
        case .green: return .green
        case .orange: return .orange
        case .red: return .red
        }
    }

    var iconName: String {
        switch self {
        case .green: return AndesIcons.feedbackSuccess40
        case .orange: return AndesIcons.feedbackWarning40
        case .red: return AndesIcons.feedbackError40
        }
    }

    case green
    case orange
    case red

    public static func keyFor(_ value: AndesFeedbackScreenColor) -> String {
        switch value {
        case .green: return "POSITIVE"
        case .orange: return "CAUTION"
        case .red: return "NEGATIVE"
        }
    }
}
