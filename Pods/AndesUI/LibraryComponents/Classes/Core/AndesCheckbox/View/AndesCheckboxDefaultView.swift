//
//  AndesCheckboxDefaultView.swift
//  AndesUI
//
//  Created by Rodrigo Pintos Costa on 6/15/20.
//

import Foundation

class AndesCheckboxDefaultView: UIView, AndesCheckboxView {

    @IBOutlet weak var label: UILabel!

	@IBOutlet weak var labelToTopConstraint: NSLayoutConstraint!
	@IBOutlet weak var labelToLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var labelToTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightBoxToTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftBoxToTopConstraint: NSLayoutConstraint!

    @IBOutlet weak var leftBox: UIImageView!
    @IBOutlet weak var rightBox: UIImageView!

    @IBOutlet weak var tappableArea: UIButton!

    @IBOutlet var checkboxView: UIView!

    weak var delegate: AndesCheckboxViewDelegate?

    var config: AndesCheckboxViewConfig

    init(withConfig config: AndesCheckboxViewConfig, delegate: AndesCheckboxViewDelegate) {
        self.config = config
        self.delegate = delegate
        super.init(frame: .zero)
        setup()
    }

    func update(withConfig config: AndesCheckboxViewConfig) {
        self.config = config
        updateView()
    }

    @IBAction func checkboxTapped(_ sender: Any) {
        self.delegate?.checkboxTapped()
    }

    func loadNib() {
       let bundle = AndesBundle.bundle()
       bundle.loadNibNamed("AndesCheckboxDefaultView", owner: self, options: nil)
    }

    override init(frame: CGRect) {
        self.config = AndesCheckboxViewConfig()
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        self.config = AndesCheckboxViewConfig()
        super.init(coder: coder)
        setup()
    }

    init() {
        self.config = AndesCheckboxViewConfig()
        super.init(frame: .zero)
        setup()
    }

    func setup() {
        loadNib()
        self.addSubview(checkboxView)
        checkboxView.pinToSuperview()
        checkboxView.translatesAutoresizingMaskIntoConstraints = false
        initialize()
        updateView()
    }

    func initialize() {
        self.label.setAndesStyle(style: AndesStyleSheetManager.styleSheet.bodyM(color: config.textColor))
        self.label.isAccessibilityElement = false
    }

    func updateView() {
        clearView()
        self.label.text = config.title
        self.label.numberOfLines = config.titleNumberOfLines
        self.label.lineBreakMode = .byTruncatingTail
        updateBoxesViews()
        updateBoxesBorders()
        updateIcons()
    }

    func updateIcons() {
        if let currentIcon = config.icon, !currentIcon.isEmpty {
            if let currentIconColor = config.iconColor {
                if self.leftBox.isHidden == false {
                    AndesIconsProvider.loadIcon(name: currentIcon) { checkboxIcon in
                        self.leftBox.image = checkboxIcon
                    }
                    self.leftBox.tintColor = currentIconColor
                } else {
                    AndesIconsProvider.loadIcon(name: currentIcon) { checkboxIcon in
                        self.rightBox.image = checkboxIcon
                    }
                    self.rightBox.tintColor = currentIconColor
                }
            }
        }
    }

    func updateBoxesViews() {
        if config.align == .left {
            self.rightBox.isHidden = true
            self.leftBox.isHidden = false
            self.leftBox.backgroundColor = config.backgroundColor
            self.leftBox.layer.cornerRadius = config.cornerRadius
            // Avoids label and check overlapping
            self.labelToLeadingConstraint.constant = 28.0
            // Adjust the leading label to show behind the hidden right check box
            self.labelToTrailingConstraint.constant = 12.0
            // Align correctly the box to the fontSize (And not the lineHeight)
			if label.text == "" {
				self.leftBoxToTopConstraint.constant = -self.labelToTopConstraint.constant
			} else {
				self.leftBoxToTopConstraint.constant =  self.label.fontSpacing
			}

            self.rightBoxToTopConstraint.constant = 0
        } else {
            self.rightBox.isHidden = false
            self.leftBox.isHidden = true
            self.rightBox.backgroundColor = config.backgroundColor
            self.rightBox.layer.cornerRadius = config.cornerRadius
            // Adjust the leading label to show behind the hidden left check box
            self.labelToLeadingConstraint.constant = 12.0
            // Avoids label and check overlapping
            self.labelToTrailingConstraint.constant = 28.0
            // Align correctly the box to the fontSize (And not the lineHeight)
            self.rightBoxToTopConstraint.constant = self.label.fontSpacing
            self.leftBoxToTopConstraint.constant = 0
        }

    }

    func updateBoxesBorders() {
        if let currentBorderColor = config.borderColor, let currentBorderSize = config.borderSize {
            if !self.leftBox.isHidden {
                self.leftBox.layer.borderColor = currentBorderColor.cgColor
                self.leftBox.layer.borderWidth = currentBorderSize
            } else {
                self.rightBox.layer.borderColor = currentBorderColor.cgColor
                self.rightBox.layer.borderWidth = currentBorderSize
            }
        }
    }

    func clearView() {
        self.leftBox.layer.borderColor = UIColor.clear.cgColor
        self.rightBox.layer.borderColor = UIColor.clear.cgColor
        self.leftBox.layer.borderWidth = 0
        self.rightBox.layer.borderWidth = 0
        self.leftBox.image = nil
        self.rightBox.image = nil
    }
}
