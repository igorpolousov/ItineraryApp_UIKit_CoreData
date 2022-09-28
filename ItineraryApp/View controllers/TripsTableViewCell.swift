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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.shadowOpacity = 1
        cellView.layer.shadowOffset = .zero
        cellView.layer.shadowColor = UIColor.darkGray.cgColor
        cellView.layer.cornerRadius = 10
    }
    
    func setup(tripModel: TripModel) {
        tripLabel.text = tripModel.title
    }

}
