//
//  AndesLabel.swift
//  testapp
//
//  Created by JULIAN BRUNO on 06/10/2021.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import Foundation
import UIKit

public class AndesLabel: UILabel, AndesAccessibleView {

    private(set) var bodyBolds: AndesBodyBolds?
    private(set) var bodyLinks: AndesBodyLinks?
    private var type: AndesLabelType = .body
    private var isLinkColorInverted: Bool = false
    private var boldAndesFontStyle = AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorPrimary,
                                                    font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: AndesFontSize.bodyM),
                                                    lineSpacing: 5,
                                                    fontLineHeight: AndesFontSizeLineHeight.bodyM)

    private var normalAndesFontStyle = AndesFontStyle(textColor: AndesStyleSheetManager.styleSheet.textColorPrimary,
                                                      font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: AndesFontSize.bodyS),
                                              lineSpacing: 5,
                                              fontLineHeight: AndesFontSizeLineHeight.bodyM)
    var accessibilityManager: AndesAccessibilityManager?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupGesture()
        self.setupBaseFont()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupGesture()
        self.setupBaseFont()
    }

    private func setupBaseFont() {
        self.font = AndesStyleSheetManager.styleSheet.regularSystemFont(size: AndesFontSize.bodyS)
    }

    @objc
    public func setStyleAsTitle(titleConfig: AndesLabelTitleConfig) {
        self.type = .title
        self.bodyLinks = titleConfig.bodyLinks
        self.bodyBolds = nil
        self.normalAndesFontStyle = titleConfig.fontStyle
        self.isLinkColorInverted = titleConfig.isLinkColorInverted
        self.setup()
    }

    @objc
    public func setStyleAsBody(bodyConfig: AndesLabelBodyConfig) {
        self.type = .body
        self.bodyLinks = bodyConfig.bodyLinks
        self.bodyBolds = bodyConfig.bodyBolds
        self.normalAndesFontStyle = bodyConfig.fontStyle
        self.boldAndesFontStyle = bodyConfig.fontStyleBold
        self.isLinkColorInverted = bodyConfig.isLinkColorInverted
        self.setup()
    }

    private func setup() {
        if let text = self.text {
            self.numberOfLines = 0
            // self.textAlignment = .left
            self.attributedText = self.getAttributedTextWithLinks(text: text)
            self.sizeToFit()
            accessibilityManager?.viewUpdated()
        }
    }

    private func setupGesture() {
        self.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapgesture)
        accessibilityManager = AndesLabelAccessibilityManager(view: self)
    }

    private func getAttributedTextWithLinks(text: String) -> NSAttributedString {

        let attributedString = NSMutableAttributedString(string: text)
        let allRange = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(.foregroundColor, value: normalAndesFontStyle.textColor, range: allRange)
        attributedString.addAttribute(.font, value: normalAndesFontStyle.font, range: allRange)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = normalAndesFontStyle.fontLineHeight / normalAndesFontStyle.font.pointSize
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: allRange)
        let linkColor = (self.isLinkColorInverted) ? AndesStyleSheetManager.styleSheet.bgColorWhite: AndesStyleSheetManager.styleSheet.textColorLink
        if let bodyBolds = self.bodyBolds {
            for (_, bold) in bodyBolds.bolds.enumerated() {
                if bold.isValidRange(attributedString) {
                    let range = NSRange(location: bold.startIndex, length: bold.endIndex - bold.startIndex)
                    attributedString.removeAttribute(.font, range: range)
                    attributedString.removeAttribute(.foregroundColor, range: range)
                    attributedString.addAttribute(.font, value: self.boldAndesFontStyle.font, range: range)
                    attributedString.addAttribute(.foregroundColor, value: boldAndesFontStyle.textColor, range: range)
                }
            }
        }

        if let bodyLinks = self.bodyLinks {
            for (_, link) in bodyLinks.links.enumerated() {
                if link.isValidRange(attributedString) {
                    let range = NSRange(location: link.startIndex, length: link.endIndex - link.startIndex)
                        let linkCustomAttributes = [
                            .foregroundColor: linkColor,
                            .underlineColor: linkColor,
                            .underlineStyle: NSUnderlineStyle.double.rawValue
                        ]  as [NSAttributedString.Key: Any]
                        attributedString.addAttributes(linkCustomAttributes, range: range)
                }
            }
        }

       return attributedString
    }

    @objc internal func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let _ = self.text, let links = self.bodyLinks?.links  else { return }
        let linksCount = links.count
        if linksCount > 0 {
            for index in 0...linksCount-1 {
                let link = links[index]
                let start = link.startIndex
                let length = link.endIndex - link.startIndex
                let range = NSRange(location: start, length: length)
                if gesture.didTapAttributedTextInLabel(label: self, inRange: range) {
                    self.bodyLinks?.listener(index)
                }
            }
        }
    }

    override public func accessibilityActivate() -> Bool {
        accessibilityManager?.accessibilityActivated()
        return accessibilityManager != nil
    }

}
