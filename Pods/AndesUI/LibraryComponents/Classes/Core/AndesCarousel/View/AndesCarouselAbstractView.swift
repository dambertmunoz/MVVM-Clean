//
//  AndesCarouselAbstractView.swift
//  AndesUI
//
//  Created by Alejo Echeguia on 09/02/2021.
//

import UIKit

class AndesCarouselAbstractView: UIView, AndesCarouselView {

    var collectionView: UICollectionView!
    var titleLabel: UILabel?
    var pageControl: AndesPageControlView!
    weak var delegate: AndesCarouselViewProtocol?
    var config: AndesCarouselViewConfig
    let andesCarouselCellID = "andesCarouselCellID"
    var titleLabelRigthConstraint: NSLayoutConstraint?

    init(withConfig config: AndesCarouselViewConfig, delegate: AndesCarouselViewProtocol? = nil) {
        self.config = config
        self.delegate = delegate
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func cleanView() {
        if collectionView != nil {
            collectionView.removeFromSuperview()
            collectionView = nil
        }
        if let titleLabel = titleLabel {
            titleLabel.removeFromSuperview()
            self.titleLabel = nil
        }
        if let pageControl = pageControl {
            pageControl.removeFromSuperview()
            self.pageControl = nil
        }
    }

    func update(withConfig config: AndesCarouselViewConfig) {
        self.config = config
        cleanView()
        setup()
    }

    internal func setup() {
        self.clipsToBounds = true
        self.backgroundColor = .clear
        createTitleLabel()
        createCollectionView()
        addPaginator()
    }

    fileprivate func createTitleLabel() {
        if !self.config.title.isEmpty {

            titleLabel = UILabel()

            if let titleLabel = self.titleLabel {
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                titleLabel.font = AndesStyleSheetManager.styleSheet.titleXS(color: AndesStyleSheetManager.styleSheet.textColorPrimary).font
                titleLabel.text = self.config.title
                self.addSubview(titleLabel)
                titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: self.config.margin).isActive = true
                titleLabelRigthConstraint = titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -self.config.margin)
                titleLabelRigthConstraint?.isActive = true
                titleLabel.sizeToFit()
            }
        }
    }

    fileprivate func createCollectionView() {

        translatesAutoresizingMaskIntoConstraints = false

        let collectionLayout = self.config.centerScroll ? AndesCollectionViewFlowLayout() : UICollectionViewFlowLayout()

        if let collectionLayout = collectionLayout as? AndesCollectionViewFlowLayout {
            collectionLayout.delegate = self
        }
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.minimumLineSpacing = self.config.cellSpacing
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionLayout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: andesCarouselCellID)
        collectionView.clipsToBounds = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        self.addSubview(collectionView)

        var topConstraint: CGFloat = 0
        if let titleLabel = self.titleLabel {
            let titleBottomPadding: CGFloat = 8
            topConstraint = titleLabel.frame.height.rounded(.up) + titleBottomPadding
        }
        collectionView.pinToSuperview(top: topConstraint, left: 0, bottom: 0, right: 0)
    }

    fileprivate func addPaginator() {
        if self.config.usePaginator {
            pageControl = AndesPageControlView(frame: .zero)
            pageControl.pages = delegate?.numberOfRow() ?? 1
            self.addSubview(pageControl)
            positionPageControl()
        }
    }

    internal func roundContentView( cell: UICollectionViewCell) {
        // Override if you need change roundContent
        cell.contentView.layer.roundContentView(with: 2.0, isMaskToBounds: true)
    }

    internal func applyShadowContetView( cell: UICollectionViewCell) {
        // Override if you need it in your view
    }

    internal func positionPageControl() {
        fatalError("This should be overriden by a subclass")
    }

    internal func getContentInset(_ section: Int) -> UIEdgeInsets {
        fatalError("This should be overriden by a subclass")
    }

    internal func getItemSize(sizeForItemAt indexPath: IndexPath) -> CGSize {
        fatalError("This should be overriden by a subclass")
    }
}

extension AndesCarouselAbstractView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return delegate?.numberOfRow() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: andesCarouselCellID, for: indexPath)
        cell.backgroundColor = .clear

        for view in cell.subviews {
            view.removeFromSuperview()
        }

        roundContentView(cell: cell)
        applyShadowContetView(cell: cell)

        let cellView = getCellView(indexPath: indexPath)
        cell.addSubview(cellView)
        cellView.pinToSuperview()

        return cell
    }

    func getCellView(indexPath: IndexPath) -> UIView {
        return (delegate?.cellForRowAt(indexPath: indexPath)) ?? UIView()
    }
}

extension AndesCarouselAbstractView: UICollectionViewDelegate, AndesCollectionViewFlowLayoutDelegate {
    func didSwitchTo(newIndex: IndexPath) {
        if let pageControl = pageControl {
            pageControl.currentPage(newIndex.row)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemAt(indexPath: indexPath)
    }
}

extension AndesCarouselAbstractView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return getItemSize(sizeForItemAt: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return getContentInset(section)
    }
}
