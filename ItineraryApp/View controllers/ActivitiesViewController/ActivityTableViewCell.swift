//
//  ActivityTableViewCell.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 15.11.2022.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        self.textLabel?.font = Theme.activityFont
        self.detailTextLabel?.font = Theme.activityFont
    }


    func setup(model: ActivityModel) {
        self.textLabel?.text = model.title
        self.detailTextLabel?.text = model.subTitle
    }
}
