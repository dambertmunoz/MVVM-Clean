//
//  AndesTextFieldAccessibilityManager.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 20/05/21.
//

import Foundation

class AndesTextFieldAccessibilityManager: AndesAccessibilityManager {

    private weak var view: AndesTextField!
    private let characterCountPercentage = 0.8
    private let minCharacterCountToAnnounce = 20
    var shouldSendAnnouncement: Bool {
        let numberOfAnnounced = Int((Double(view.counter) * characterCountPercentage).rounded(.toNearestOrEven))
        return view.counter >= minCharacterCountToAnnounce && view.text.count == numberOfAnnounced
    }

    required init(view: UIView) {
        guard let textField = view as? AndesTextField else {
            fatalError("TextField AccessibilityManager should recieve an AndesTextField")
        }
        self.view = textField
        viewUpdated()
    }

    func viewUpdated() {
        view.contentView.accessibilityLabel = createAccessibilityLabel(textField: view)
        updateAccessibilityNavigation()
        updateAccessibilitySideComponents()
        checkForCharactersAnnouncement()
    }

    func accessibilityActivated() {
        view.becomeFirstResponder()
    }

    private func checkForCharactersAnnouncement() {
        if shouldSendAnnouncement {
            let message = "%d caracteres restantes".localizeWithFormat(arguments: Int(view.counter) - view.text.count)
            makeAnnouncement(type: .message(message: message))
        }
    }

    private func updateAccessibilityNavigation() {
        view.contentView.accessibilityTraits = view.state.accessibilityTraits
        view.contentView.isAccessibilityElement = true
        view.accessibilityElements = [view.contentView,
                                      view.state == .readOnly ? nil : view.contentView.innerTextField as Any].compactMap { $0 }
    }

    private func updateAccessibilitySideComponents() {
        disableAccessibilityLeftComponent()
        let rightComponent = view.contentView.innerTextField?.rightView
        switch rightComponent {
        case let actionComponent as AndesTextFieldActionView:
            setupAccessibilityRightComponent(actionComponent, traits: .button, label: actionComponent.label)
        case let labelComponent as AndesTextFieldLabelView:
            setupAccessibilityRightComponent(labelComponent, traits: .none, label: labelComponent.text)
        case let clearComponent as AndesTextFieldClearView:
            setupAccessibilityRightComponent(clearComponent, traits: .button, label: "Borrar texto".localized())
        default:
            disableAccessibilityRightComponent(rightComponent)
        }
    }

    private func setupAccessibilityRightComponent(_ view: UIView, traits: UIAccessibilityTraits, label: String?) {
        view.isAccessibilityElement = true
        view.accessibilityTraits = traits
        view.accessibilityLabel = label
    }

    private func disableAccessibilityRightComponent(_ rightComponent: UIView?) {
        rightComponent?.isAccessibilityElement = false
    }

    private func disableAccessibilityLeftComponent() {
        let leftComponent = view.contentView.innerTextField?.leftView
        leftComponent?.isAccessibilityElement = false
        leftComponent?.accessibilityElementsHidden = true
    }

    private func createAccessibilityLabel(textField: AndesTextField) -> String {
        var accessibilityLabel: String = ""

        switch textField.state {
        case .idle, .disabled:
            accessibilityLabel += "\(labelText) \(helperText) \(characterCounterText) \(prefixText) \(innerText)" + "Campo de texto".localized()
        case .readOnly:
            accessibilityLabel += "\(labelText) \(prefixText) \(innerText)"
        case .error, .warning:
            accessibilityLabel += "\(labelText) \(stateText) \(helperText) \(characterCounterText) \(prefixText) \(innerText)" + "Campo de texto".localized()
        }
        return accessibilityLabel
    }

    private func createLeftComponentAccessiblityText(_ leftComponent: AndesTextFieldLeftComponent?) -> String? {
        switch leftComponent {
        case let component as AndesTextFieldComponentLabel:
            component.isAccessibilityElement = false
            component.accessibilityElementsHidden = true
            return component.text
        default:
            return nil
        }
    }

}

// MARK: - Accessibility label computed properties
private extension AndesTextFieldAccessibilityManager {
    var helperText: String {
        if let helperText = view.helper, helperText != "" {
            return helperText + ","
        }
        return ""
    }
    var prefixText: String {
        if let leftComponentText = createLeftComponentAccessiblityText(view.leftContent) {
            return leftComponentText + ","
        }
        return ""
    }

    var characterCounterText: String {
        if view.contentView != nil,
           view.text.count > .zero,
           view.counter > .zero {
            return "caracteres ingresados %d de %d.".localizeWithFormat(arguments: view.text.count, view.counter)
        } else if view.counter > .zero {
            return "máximo número de caracteres:".localized() + " \(view.counter)."
        }
        return ""
    }

   var labelText: String {
        if let title = view.label,
           title != "" {
            return title + ","
        }
        return ""
    }

    var stateText: String {
        if let stateText = view.state.accessibilityText {
            return stateText + ","
        }
        return ""
    }

    var innerText: String {
        if let placeHolder = self.view.placeholder,
           view.contentView != nil,
           view.text.count == .zero {
            return placeHolder + "."
        }
        return ""
    }
}
