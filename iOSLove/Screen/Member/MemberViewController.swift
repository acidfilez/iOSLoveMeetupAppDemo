//
//  MemberViewController.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/30/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import UIKit

internal final class MemberViewController: UIViewController {

    @IBOutlet fileprivate weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(MemberCell.self)
        }
    }

    fileprivate let presenter: MemberPresenter

    init(presenter: MemberPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension MemberViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MemberCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.configure(with: presenter.itemPresenter(at: indexPath))
        return cell
    }
}

extension MemberViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.selectItem(at: indexPath)
    }
}
