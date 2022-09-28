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
        cellView.applyDesign()
    }
    
    func setup(tripModel: TripModel) {
        tripLabel.text = tripModel.title
    }

}
