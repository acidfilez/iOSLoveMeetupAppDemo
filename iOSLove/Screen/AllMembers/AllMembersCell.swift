//
//  AllMembersCell.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/30/18.
//  Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import UIKit
import Kingfisher

internal final class AllMembersCell: UICollectionViewCell, ReusableNibView {
    
    @IBOutlet private weak var thumbImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.apply(styles: .rounded)
        nameLabel.apply(styles: .memberCellTitle)
    }

    func configure(with presenter: AllMembersCellPresenter) {
        let kfImageView: Kingfisher<UIImageView> = Kingfisher(thumbImageView)
        
        nameLabel.text = presenter.name
        if let url = presenter.thumbURL {
            kfImageView.setImage(with: url)
        } else {
            kfImageView.cancelDownloadTask()
            kfImageView.setImage(with: nil)
        }
    }
}
