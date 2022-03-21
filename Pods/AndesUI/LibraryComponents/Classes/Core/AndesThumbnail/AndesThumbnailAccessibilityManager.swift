//
//  AndesThumbnailAccessibilityManager.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 30/07/21.
//

import Foundation

class AndesThumbnailAccessibilityManager: AndesAccessibilityManager {
    private weak var view: AndesThumbnail!

	required init(view: UIView) {
		guard let accessibleView = view as? AndesThumbnail else {
			fatalError("AndesThumbnailAccessibilityManager should recieve an AndesThumbnail")
		}
		self.view = accessibleView
	}

	func viewUpdated() {

		view.isAccessibilityElement = false
	}

	func accessibilityActivated() {
		// Not needed
	}
}
