//
//  AddDayViewController.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 19.11.2022.
//

import UIKit

class AddDayViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addDayLabel: UILabel!
    @IBOutlet weak var titleDateTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: PopUpViewButtons!
    @IBOutlet weak var cancelButton: PopUpViewButtons!
    
    // Call back function for sending data to another class "Trips view controller"
    var doneSavings: (()->())?
    var tripIndexToEdit: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDayLabel.font = Theme.mainFont?.withSize(26)
        // Drop shadow title
        addDayLabel.setupWhiteShadow()
        
        if let index = tripIndexToEdit {
            let trip = Data.tripModels[index]
            let day = trip.dayModels[index]
            titleDateTextField.text = day.title
            imageView.image = trip.image
            addDayLabel.text = "Edit Trip"
        }
        
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func saveAction(_ sender: UIButton) {
        //titleDateTextField.rightViewMode = .never
        
        guard titleDateTextField.text != "", let text = titleDateTextField.text  else {
            //Show warning image if no text were entered
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = UIImage(named: "warning")
            titleDateTextField.rightView = imageView
            
            return
        }
//        if let index = tripIndexToEdit {
//            TripFunctions.updateTrip(at: index, title: text, image: imageView.image)
//        } else {
//            TripFunctions.createTrip(tripModel: TripModel(title: text, image: imageView.image))
//        }
        
        if let doneSavings = doneSavings {
            doneSavings()
        }
        dismiss(animated: true)
    }

}
