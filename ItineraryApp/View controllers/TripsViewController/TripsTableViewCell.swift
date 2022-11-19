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
        tripLabel.textColor = .white
        tripLabel.layer.shadowOffset = .zero
        tripLabel.layer.shadowColor = UIColor.black.cgColor
        tripLabel.layer.shadowRadius = 10
        tripLabel.layer.shadowOpacity = 1.0
        
        cellView.backgroundColor = Theme.accentColor
        
        tripImgeView.layer.cornerRadius = cellView.layer.cornerRadius
    }
    
    func setup(tripModel: TripModel) {
        tripLabel.text = tripModel.title
        
        if let tripImage = tripModel.image {
            tripImgeView.alpha = 0.5
            tripImgeView.image = tripImage
            UIView.animate(withDuration: 1) {
                self.tripImgeView.alpha = 1
            }
        }
    }
}
