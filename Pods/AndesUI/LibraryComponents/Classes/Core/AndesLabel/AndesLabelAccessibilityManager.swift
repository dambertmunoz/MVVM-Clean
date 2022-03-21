//
//  AndesLabelAccessibilityManager.swift
//  AndesUI
//
//  Created by Gerardo Tarazona Caceres on 9/11/21.
//

import Foundation

class AndesLabelAccessibilityManager: AndesAccessibilityManager {
    private var view: AndesLabel
    required init(view: UIView) {
        guard let accessibleView = view as? AndesLabel else {
            fatalError("AndesCheckboxAccessibilityManager should recieve an AndesCheckbox")
        }
        self.view = accessibleView
    }

    func viewUpdated() {
        view.accessibilityTraits = .staticText

        view.accessibilityLabel = view.text
        view.accessibilityHint = view.bodyLinks?.links.count ?? 0 > 0 ? "links disponibles, doble tap para listarlos".localized() : ""
    }

    func accessibilityActivated() {
        guard let links = view.bodyLinks?.links else { return }
        let topViewController = UIApplication.getTopViewController()
        let linksAlert = UIAlertController(title: "Links disponibles".localized(), message: nil, preferredStyle: .actionSheet)

        for (index, link) in links.enumerated() {
            let range = NSRange(location: link.startIndex, length: link.endIndex - link.startIndex)
            let actionTitle = (view.text as NSString?)?.substring(with: range)
            linksAlert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { [weak view] _ in
                view?.bodyLinks?.listener(index)
            }))
        }

        linksAlert.addAction(UIAlertAction(title: "Cancelar".localized(), style: .default, handler: { [weak linksAlert] _ in
            linksAlert?.dismiss(animated: true, completion: nil)
        }))

        topViewController?.present(linksAlert, animated: true, completion: nil)
    }

}
