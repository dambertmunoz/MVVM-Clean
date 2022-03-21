//
//  AndesPageControlView.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 13/04/2021.
//

public protocol AndesScrollingPageControlDelegate: class {
    func viewForDot(at index: Int) -> UIView?
}

open class AndesPageControlView: UIView {

    private var lastSize = CGSize.zero
    private var centerOffset = 0
    private let scaleArray = [1, 0.66, 0.33, 0.16]
    private let slideDuration: TimeInterval = 0.15
    private var spacing: CGFloat!
    private var dotSize: CGFloat!
    private var maxDots: Int!
    private var centerDots: Int!
    private var selectedPage: Int = 0

    open weak var delegate: AndesScrollingPageControlDelegate? {
        didSet {
            createViews()
        }
    }

    open var pages: Int = 0 {
        didSet {
            guard pages != oldValue else { return }
            pages = max(0, pages)
            createViews()
        }
    }

    private var pageOffset = 0 {
        didSet {
            UIView.animate(withDuration: slideDuration, delay: 0, options: [], animations: self.updatePositions, completion: nil)
        }
    }

    private var dotViews: [UIView] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            dotViews.forEach(addSubview)
            updateColors()
            updatePositions()
        }
    }

    open var dotColor = UIColor.Andes.graySolid250 {
        didSet {
            updateColors()
        }
    }
    open var selectedColor = AndesStyleSheetManager.styleSheet.accentColor { didSet { updateColors() } }

    // MARK: Init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureDots()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
        self.configureDots()
    }

    func configureDots(dotSize: CGFloat = 6, spacing: CGFloat = 4) {
        self.spacing = spacing
        self.dotSize = dotSize
        if pages <= 5 {
            self.maxDots = 5
            self.centerDots = 5
        } else {
            self.maxDots = 7
            self.centerDots = 3
        }
        self.dotViews.forEach {
            $0.frame = CGRect(origin: .zero, size: CGSize(width: dotSize, height: self.dotSize))
        }

        updatePositions()
    }

    private func createViews() {
        configureDots()
        dotViews = (0..<pages).map { index in
            delegate?.viewForDot(at: index) ?? AndesPageDotView(frame: CGRect(origin: .zero, size: CGSize(width: dotSize, height: dotSize)))
        }
    }

    func currentPage(_ page: Int) {
        guard selectedPage != page else { return }
        selectedPage = max(0, min(page, pages - 1))
        updateColors()
        if (0..<centerDots).contains(selectedPage - pageOffset) {
            centerOffset = selectedPage - pageOffset
        } else {
            pageOffset = selectedPage - centerOffset
        }
    }

    func getDotSize() -> CGFloat {
        return self.dotSize
    }

    // MARK: updates methods
    private func updateColors() {
        dotViews.enumerated().forEach { page, dot in
            dot.tintColor = page == selectedPage ? selectedColor : dotColor
            dot.layer.borderColor = page == selectedPage ? dotColor.cgColor : selectedColor.cgColor
        }
    }

    private func updatePositions() {
        let sidePages = (maxDots - centerDots) / 2
        let dotFullSize = dotSize + spacing
        let horizontalOffset = CGFloat(-pageOffset + sidePages) * dotFullSize + (bounds.width - intrinsicContentSize.width) / 2
        let centerPage = centerDots / 2 + pageOffset

        dotViews.enumerated().forEach { page, dot in
            let scale: CGFloat = {
                let distance = abs(page - centerPage)
                if distance > (maxDots / 2) { return 0 }
                return CGFloat(scaleArray[max(0, min(self.centerDots, distance - centerDots / 2))])
            }()
            let newSize = dotSize * scale
            dot.frame = CGRect(origin: .zero, size: CGSize(width: newSize, height: newSize))

            let center = CGPoint(x: horizontalOffset + bounds.minX + dotSize / 2 + dotFullSize * CGFloat(page), y: bounds.midY)
            dot.center = center
        }
    }

    // MARK: override methods
    open override func layoutSubviews() {
        super.layoutSubviews()
        guard bounds.size != lastSize else { return }
        lastSize = bounds.size
        updatePositions()
    }

    open override var intrinsicContentSize: CGSize {

        let maxDistance = 4
        var numberOfDots = self.pages
        let dotSize = self.dotSize ?? 0

        if self.pages > centerDots {
            numberOfDots = centerDots + maxDistance
        }
        let width = CGFloat(numberOfDots) * dotSize + CGFloat(numberOfDots - 1) * spacing
        let height = dotSize

        return CGSize(width: width, height: height)
    }
}
