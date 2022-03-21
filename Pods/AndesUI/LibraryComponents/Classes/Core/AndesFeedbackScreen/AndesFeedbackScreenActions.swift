//
//  AndesFeedbackScreenActions.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 02/09/2021.
//

@objc public class AndesFeedbackScreenActions: NSObject {
    let actionButton: AndesFeedbackScreenButton?
    let closeButtonCallback:  (() -> Void)?

    @objc public init(actionButton: AndesFeedbackScreenButton, closeButtonCallback: (() -> Void )?  ) {
        self.actionButton = actionButton
        self.closeButtonCallback = closeButtonCallback
    }

    @objc public init(closeButtonCallback: @escaping (() -> Void )) {
        self.actionButton = nil
        self.closeButtonCallback = closeButtonCallback
    }
}
