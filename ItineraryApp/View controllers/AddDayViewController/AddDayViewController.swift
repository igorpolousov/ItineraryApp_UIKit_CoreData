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
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: PopUpViewButtons!
    @IBOutlet weak var cancelButton: PopUpViewButtons!
    
    // Call back function for sending data to another class "Trips view controller"
    var doneSavings: ((DayModel)->())?
    var tripIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.frame = CGRect(x: 0, y: 60, width: 360, height: 140)
        addDayLabel.font = Theme.mainFont?.withSize(26)
        // Drop shadow title
        addDayLabel.setupWhiteShadow()
        
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
          
        let dayModel = DayModel(title: datePicker.date, subtitle: descriptionTextField.text ?? "")
        
        DayFunctions.createDay(tripIndex: tripIndex!, dayModel: dayModel)
        
        if let doneSavings = doneSavings {
            doneSavings(dayModel)
        }
        dismiss(animated: true)
    }

}
