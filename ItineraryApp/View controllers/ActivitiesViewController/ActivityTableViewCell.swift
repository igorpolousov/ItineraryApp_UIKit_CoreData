//
//  ActivityTableViewCell.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 15.11.2022.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
   
        activityView.backgroundColor = Theme.accentColor
        activityView.layer.cornerRadius = 10
        contentView.backgroundColor = .clear
    }


    func setup(model: ActivityModel) {
        
        titleLabel.font = Theme.activityFont
        subtitleLabel.font = Theme.activityFont
        titleLabel.textColor = .lightGray
        subtitleLabel.textColor = .lightGray
//        titleLabel.setupWhiteShadow()
//        subtitleLabel.setupWhiteShadow()
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle

        activityImageView.tintColor = Theme.tintColor
        

            switch model.activityType {
            case 0:
                activityImageView.image = UIImage(named: "taxi")
            case 1:
                activityImageView.image = UIImage(named: "flight")
            case 2:
                activityImageView.image = UIImage(named: "train")
            case 3:
                activityImageView.image = UIImage(named: "food")
            case 4:
                activityImageView.image = UIImage(named: "hotel")
            default:
                activityImageView.image = UIImage(named: "food")
            }
    }
}
