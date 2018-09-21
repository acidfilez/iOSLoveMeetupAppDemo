//
//  AllMembersViewController.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/30/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import UIKit

internal final class AllMembersViewController: UIViewController {
    fileprivate struct Constants {
        static let itemSpacing: CGFloat = 12
        static let itemsPerRow = 3
    }

    @IBOutlet fileprivate weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(AllMembersCell.self)
        }
    }

    fileprivate let presenter: AllMembersPresenter

    init(presenter: AllMembersPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onUpdate = { [weak self] in
            self?.configure()
        }
        presenter.load()
    }
    
    private func configure() {
        title = presenter.title
        collectionView.reloadData()
    }
}

extension AllMembersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AllMembersCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(with: presenter.itemPresenter(at: indexPath))
        return cell
    }
}

extension AllMembersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.selectItem(at: indexPath)
    }
}

extension AllMembersViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let emptySpace = CGFloat(Constants.itemsPerRow + 1) * Constants.itemSpacing
        let remainingSpace = collectionView.frame.width - emptySpace
        let itemWidth = remainingSpace / CGFloat(Constants.itemsPerRow)
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: Constants.itemSpacing, bottom: 0, right: Constants.itemSpacing)
    }
}
