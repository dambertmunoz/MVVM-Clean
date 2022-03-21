//
//  AndesAutosuggest.swift
//  AndesUI
//
//  Created by Santiago Lazzari on 22/05/2021.
//

import UIKit

public class AndesAutosuggest: UIView {

    // Private/internal Attributes
    var contentView: AndesAutosuggestView!
    private(set) var inputTraits: UITextInputTraits? {
        didSet {
            self.updateContentView()
        }
    }

    // Public
    public weak var delegate: AndesAutosuggestDelegate?
    public weak var datasource: AndesAutosuggestDatasource?

    public var state: AndesTextInputState = .idle {
        didSet {
            self.updateContentView()
        }
    }

    @IBInspectable public var label: String? {
        didSet {
            self.updateContentView()
        }
    }

    @IBInspectable public var helper: String? {
        didSet {
            self.updateContentView()
        }
    }

    @IBInspectable public var placeholder: String? {
        didSet {
            self.updateContentView()
        }
    }

    public var leftContent: AndesTextFieldLeftComponent? {
        didSet {
            self.updateContentView()
        }
    }

    /// sets the right component
    public var rightContent: AndesTextFieldRightComponent? {
        didSet {
            self.updateContentView()
        }
    }

    public var textInputTraits: AndesTextInputTraits = .custom {
        didSet {
            guard textInputTraits != .custom else {
                return
            }
            inputTraits = AndesTextInputTraitsFactory.getTraits(for: textInputTraits)
        }
    }

    public func setCustomInputTraits(_ traits: UITextInputTraits) {
        self.inputTraits = traits
        self.textInputTraits = .custom
    }

    @IBInspectable public var counter: UInt16 = 0 {
        didSet {
            self.updateContentView()
        }
    }

    @IBInspectable public var text: String {
        get { return contentView.text }
        set { contentView.text = newValue }
    }

    // Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public init(state: AndesTextInputState, label: String?, helper: String?, counter: UInt16, placeholder: String?) {
        super.init(frame: .zero)
        self.label = label
        self.helper = helper
        self.placeholder = placeholder
        self.counter = counter
        self.state = state
        setup()
    }
}

// Public Methods
extension AndesAutosuggest {
    public func reloadData() {
        contentView.reloadData()
    }

    @discardableResult
    public override func resignFirstResponder() -> Bool {
        contentView.resignFirstResponder()
    }

    @discardableResult
    public override func becomeFirstResponder() -> Bool {
        contentView.becomeFirstResponder()
    }

    public override var isFirstResponder: Bool {
        return contentView.isFirstResponder
    }
}

// Private Methods
extension AndesAutosuggest {
    private func drawContentView(with newView: AndesAutosuggestAbstractView) {
        self.contentView = newView
        contentView.delegate = self
        contentView.datasource = self
        addSubview(contentView)
        contentView.pinToSuperview()
    }

    private func provideView() -> AndesAutosuggestAbstractView {
        return AndesAutosuggestDefaultView(config: configFromAtributes())
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        drawContentView(with: provideView())
    }

    private func updateContentView() {
        contentView.update(with: configFromAtributes())
    }

    private func configFromAtributes() -> AndesAutosuggestViewConfig {
        return AndesAutosuggestViewConfigFactory.provideInternalConfig(autosuggest: self)
    }
}

extension AndesAutosuggest: AndesAutosuggestViewDelegate {
    func didChange() {
        delegate?.andesAutosuggestDidChange?(self)
    }

    func didBeginEditing() {
        updateContentView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        delegate?.andesAutosuggestDidBeginEditing?(self)
    }

    @objc private func keyboardDidShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
            let keyboardSize = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size else { return }

        let superViewBouns = superView().bounds
        let availableFrame = CGRect(x: superViewBouns.minX, y: superViewBouns.minY, width: superViewBouns.width, height: superViewBouns.height - keyboardSize.height)
        contentView.showSuggestions(availableFrame: availableFrame)
    }

    func didEndEditing(text: String) {
        NotificationCenter.default.removeObserver(self)
        delegate?.andesAutosuggestDidEndEditing?(self)
    }

    func shouldBeginEditing() -> Bool {
        return delegate?.andesAutosuggestShouldBeginEditing?(self) ?? true
    }

    func shouldEndEditing() -> Bool {
        return delegate?.andesAutosuggestShouldEndEditing?(self) ?? true
    }

    func textField(shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return delegate?.andesAutosuggest?(self, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }

    func didChangeSelection(selectedRange range: UITextRange?) {
        if #available(iOS 13, *) {
            delegate?.andesAutosuggestDidChangeSelection?(self, selectedRange: range)
        }
    }

    func didTapRightAction() {
        delegate?.andesAutosuggestDidTapRightAction?(self)
    }

    func shouldReturn() -> Bool {
        return delegate?.andesAutosuggestShouldReturn?(self) ?? true
    }

    func didDeleteBackward(_ andWasEmpty: Bool) {
        delegate?.andesAutosuggest?(self, didDeleteBackwardAnd: andWasEmpty)
    }

    func suggestionWasTapped(suggestion: String) {
        text = suggestion
        updateContentView()
        contentView.hideSuggestions()
        delegate?.andesAutosuggestSuggestionWasTapped?(self, suggestion: suggestion)
    }
}

extension AndesAutosuggest: AndesAutosuggestViewDatasource {

    func suggestions() -> [String] {
        return datasource?.andesAutosuggestSuggestions(self) ?? []
    }

    func superView() -> UIView {
        guard let firstWindow = UIApplication.shared.windows.first,
              let rootViewController = firstWindow.rootViewController else {
            return datasource?.andesAutosuggestSuperView?(self) ?? UIView()
        }

        return datasource?.andesAutosuggestSuperView?(self) ?? rootViewController.view
    }
}

// MARK: - IB Enum Adapters
public extension AndesAutosuggest {
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'state' instead.")
    @IBInspectable var ibState: String {
        set(val) {
            self.state = AndesTextInputState.checkValidEnum(property: "IB State", key: val)
        }
        get {
            return self.state.toString()
        }
    }
}
