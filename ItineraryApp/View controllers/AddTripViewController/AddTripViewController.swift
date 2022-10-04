//
//  AddTripViewController.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 04.10.2022.
//

import UIKit

class AddTripViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tripTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    // Call back function
    var doneSavings: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        titleLabel.font = Theme.mainFont?.withSize(26)
      
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        if let text = tripTextField.text {
            TripFunctions.createTrip(tripModel: TripModel(title: text))
        }
        if let doneSavings = doneSavings {
            doneSavings()
        }
        dismiss(animated: true)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
