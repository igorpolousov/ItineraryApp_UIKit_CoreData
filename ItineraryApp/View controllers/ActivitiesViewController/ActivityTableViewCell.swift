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
        titleLabel.setupWhiteShadow()
        subtitleLabel.setupWhiteShadow()
        titleLabel.text = model.title
        subtitleLabel.text = model.subTitle

        activityImageView.tintColor = Theme.tintColor
        

            switch model.activityType {
            case .auto:
                activityImageView.image = UIImage(named: "taxi")
            case .bicyclePlain:
                activityImageView.image = UIImage(named: "bicycle")
            case .bicycleMountain:
                activityImageView.image = UIImage(named: "bicycle")
            case .bicycleMud:
                activityImageView.image = UIImage(named: "bicycle")
            case .waterTransfer:
                activityImageView.image = UIImage(named: "bicycle")
            case .flight:
                activityImageView.image = UIImage(named: "flight")
            case .train:
                activityImageView.image = UIImage(named: "train")
            case .suburbanTrain:
                activityImageView.image = UIImage(named: "suburbanTrain")
            case .food:
                activityImageView.image = UIImage(named: "hotel")
            case .hotel:
                activityImageView.image = UIImage(named: "hotel")
            }
    }
}
