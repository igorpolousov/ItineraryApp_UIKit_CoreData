//
//  TripsTableViewCell.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 28.09.2022.
//

import UIKit

class TripsTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var tripLabel: UILabel!
    @IBOutlet weak var tripImgeView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = Theme.backgroundColor
        
        cellView.applyDesign()
        tripLabel.font = Theme.mainFont
        tripLabel.textColor = Theme.tintColor
        tripLabel.layer.shadowColor = UIColor.white.cgColor
        tripLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        tripLabel.layer.shadowOpacity = 0.7
        tripLabel.layer.shadowRadius = 0.8
        
        cellView.backgroundColor = Theme.accentColor
        
        tripImgeView.layer.cornerRadius = cellView.layer.cornerRadius
    }
    
    func setup(tripModel: TripModel) {
        tripLabel.text = tripModel.title
        
        if let tripImage = tripModel.image {
            tripImgeView.alpha = 0.3
            tripImgeView.image = tripImage
            UIView.animate(withDuration: 1) {
                self.tripImgeView.alpha = 1
            }
            
        }
        
    }

}
