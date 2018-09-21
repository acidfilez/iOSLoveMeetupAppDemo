//
//  EventCell.swift
//  iOSLove
//
//  Created by Camilo Vera Bezmalinovic on 8/30/18.
//Copyright © 2018 Camilo Vera Bezmalinovic. All rights reserved.
//

import UIKit

internal final class EventCell: UITableViewCell, ReusableNibView {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var venueLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.apply(styles: .cellTitle)
        venueLabel.apply(styles: .cellSubtitle)
        statusLabel.apply(styles: .cellSubtitle)
    }
    
    func configure(with presenter: EventCellPresenter) {
        nameLabel.text = presenter.name
        venueLabel.text = presenter.venueName
        statusLabel.text = presenter.status
    }
}
