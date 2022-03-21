//
//  AndesDatePickerHeaderView.swift
//  AndesUI
//
//  Created by Ândriu Felipe Coelho on 09/11/20.
//

import UIKit

protocol AndesDatePickerHeaderViewDelegate: AnyObject {
    func nextMonth()
    func previousMonth()
}

class AndesDatePickerHeaderView: UICollectionReusableView {

    enum DaysOfWeek: Int {
        case monday = 1, tuesday, wednesday, thursday, friday, saturday, sunday
    }

    // MARK: - Attributes

    static let identifier = String(describing: AndesDatePickerHeaderView.self)
    weak var delegate: AndesDatePickerHeaderViewDelegate?

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale.init(identifier: Locale.preferredLanguages.first ?? Locale.current.identifier)
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter
    }()

    var currentDate = Date() {
        didSet {
            monthLabel.text = dateFormatter.string(from: currentDate).capitalized
        }
    }

    // MARK: - UIComponents

    private let weekDaysStackView: UIStackView = {
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .center
        horizontalStack.distribution = .fillEqually
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false

        return horizontalStack
    }()

    private lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = AndesStyleSheetManager.styleSheet.textColorPrimary
        label.font = AndesStyleSheetManager.styleSheet.regularSystemFont(size: 16.0)

        return label
    }()

    private(set) var previousButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTouchPreviousMonth), for: .touchUpInside)

        return button
    }()

    private let nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTouchNextMonth(_:)), for: .touchUpInside)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(weekDaysStackView)

        weekDaysStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        weekDaysStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        weekDaysStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true

        addSubview(monthLabel)
        monthLabel.bottomAnchor.constraint(equalTo: weekDaysStackView.topAnchor, constant: -20).isActive = true
        monthLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        addSubview(previousButton)
        AndesIconsProvider.loadIcon(name: AndesIcons.chevronLeft24) { icon in
            previousButton.setImage(icon.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        previousButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor).isActive = true
        previousButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        previousButton.widthAnchor.constraint(equalTo: previousButton.widthAnchor, constant: 24).isActive = true
        previousButton.heightAnchor.constraint(equalTo: previousButton.heightAnchor, constant: 24).isActive = true
        previousButton.accessibilityLabel = "Mes anterior".localized()
        previousButton.accessibilityTraits = .button

        addSubview(nextButton)
        AndesIconsProvider.loadIcon(name: AndesIcons.chevronRight24) { icon in
            nextButton.setImage(icon.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        nextButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor).isActive = true
        nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8).isActive = true
        nextButton.widthAnchor.constraint(equalTo: previousButton.widthAnchor, constant: 24).isActive = true
        nextButton.heightAnchor.constraint(equalTo: previousButton.heightAnchor, constant: 24).isActive = true
        nextButton.accessibilityLabel = "Siguiente Mes".localized()
        nextButton.accessibilityTraits = .button

        accessibilityElements = [previousButton, monthLabel, nextButton]
        populateDaysOfWeek()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func populateDaysOfWeek() {
        for day in 1...7 {
            let label = UILabel()
            label.text = getDayOfWeek(number: day)
            label.textAlignment = .center
            label.font = AndesStyleSheetManager.styleSheet.regularSystemFont(size: 10.0)
            label.textColor = AndesStyleSheetManager.styleSheet.textColorSecondary
            label.isAccessibilityElement = false

            weekDaysStackView.addArrangedSubview(label)
        }
    }

    private func getDayOfWeek(number: Int) -> String {
        switch DaysOfWeek(rawValue: number) {
        case .monday:
            return "SEG".localized()
        case .tuesday:
            return "TER".localized()
        case .wednesday:
            return "QUA".localized()
        case .thursday:
            return "QUI".localized()
        case .friday:
            return "SEX".localized()
        case .saturday:
            return "SAB".localized()
        case .sunday:
            return "DOM".localized()
        default:
            return ""
        }
    }

    func togglePreviousButton(days: [AndesDayDatePicker], compareDate: Date? = nil) {
        let calendar = Calendar(identifier: .gregorian)
        previousButton.isEnabled = true
        for day in days {
            if let startDate = day.startDate {
                let sameMonth = calendar.compare(day.date, to: startDate, toGranularity: .day) == .orderedAscending
                if sameMonth {
                    previousButton.isEnabled = false
                }
            }
        }
    }

    func toggleNextButton(days: [AndesDayDatePicker], compareDate: Date? = nil) {
        let calendar = Calendar(identifier: .gregorian)
        nextButton.isEnabled = true
        for day in days {
            if let dueDate = day.dueDate {
                let sameMonth = calendar.compare(day.date, to: dueDate, toGranularity: .day) == .orderedDescending
                if sameMonth {
                    nextButton.isEnabled = false
                }
            }
        }
    }

    // MARK: - IBActions

    @objc func didTouchPreviousMonth(_ sender: UIButton) {
        delegate?.previousMonth()
    }

    @objc func didTouchNextMonth(_ sender: UIButton) {
        delegate?.nextMonth()
    }
}
