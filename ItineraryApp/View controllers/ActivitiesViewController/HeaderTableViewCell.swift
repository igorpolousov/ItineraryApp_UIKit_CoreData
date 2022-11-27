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
        titleLabel.text =  model.title.mediumStyleDate()
        subtitleLabel.text = model.subtitle
    }
}
