//
//  HeaderTableViewCell.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 15.11.2022.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = Theme.dayFont
        subtitleLabel.textColor = Theme.tintColor
        
    }

    func setup(model: DayModel) {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        titleLabel.text = formatter.string(from: model.title)
        subtitleLabel.text = model.subtitle
    }
}
