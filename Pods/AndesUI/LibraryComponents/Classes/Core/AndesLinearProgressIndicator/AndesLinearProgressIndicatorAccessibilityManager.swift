//
//  AndesLinearProgressIndicatorAccessibilityManager.swift
//  AndesUI
//
//  Created by Jhon Alexander Ospino Bernal on 8/09/21.
//

import Foundation

class AndesLinearProgressIndicatorAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesLinearProgressIndicator!

    required init(view: UIView) {
        guard let accessibleView = view as? AndesLinearProgressIndicator else {
            fatalError("AndesLinearProgressIndicatorAccessibilityManager should recieve an AndesLinearProgressIndicator")
        }
        self.view = accessibleView
        viewUpdated()
    }

    func viewUpdated() {
        view.isAccessibilityElement = true
        view.accessibilityTraits = .none
        if let linearProgress = view as? AndesLinearProgressIndicatorDeterminate {
            view.accessibilityLabel = "\(linearProgress.currentStep)\("inProgress".localized())"
        } else {
            view.accessibilityLabel = "inProgress".localized()
        }
    }

    func accessibilityActivated() {

    }
}
