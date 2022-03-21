//
//  AndesFeedbackScreenButtonContainer.swift
//  AndesUI
//
//  Created by JULIAN BRUNO on 25/08/2021.
//

import UIKit
import PureLayout

class AndesFeedbackScreenButtonContainerView: UIView {
    private let actionButtonText: String
    private let margin: CGFloat = 20

    private lazy var primaryButton: AndesButton = {
        let button = AndesButton(text: self.actionButtonText, hierarchy: .loud, size: .large)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tappedPrimaryButton), for: .touchUpInside)
        button.accessibilityIdentifier = "ANDES_FEEDBACK_VIEW_ PRIMARY_BUTTON"
        return button
    }()

    private let buttonContainerView: UIView = {
        let containerView = UIView(forAutoLayout: ())
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.clear
        return containerView
    }()

    @objc func tappedPrimaryButton(_ btn: UIControl) {
        self.callback()
    }

    private(set) var callback:() -> Void

    public init(actionButtonText: String, callback:@escaping () -> Void) {
        self.actionButtonText = actionButtonText
        self.callback = callback
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.addSubview(self.buttonContainerView)
        self.buttonContainerView.addSubview(self.primaryButton)
        self.primaryButton.autoPinEdge(toSuperviewEdge: .top)
        self.primaryButton.autoPinEdge(toSuperviewEdge: .leading, withInset: margin)
        self.primaryButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: margin)
        self.primaryButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: margin)
        self.primaryButton.autoSetDimension(.height, toSize: 48)
        self.buttonContainerView.autoPinEdgesToSuperviewEdges()
    }

}
