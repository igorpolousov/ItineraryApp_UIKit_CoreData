//
//  AddDayViewController.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 19.11.2022.
//

import UIKit
import CoreData

class AddDayViewController: UIViewController {
    
    var coreDataStack = CoreDataStack(modelName: "ItineraryApp")
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addDayLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: PopUpViewButtons!
    @IBOutlet weak var cancelButton: PopUpViewButtons!
    
    // Call back function for sending data to another class "Trips view controller"
    var doneSavings: ((DayModel)->())?
    var tripIndex: Int?
    var tripModel: TripModel!
    
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
    
    @IBAction func done(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        if dayAlreadyExists(datePicker.date) {
            let ac = UIAlertController(title: "Such a day already exists", message: "Choose another date", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
            present(ac, animated: true)
        } else {
            //let dayModel = DayModel(title: datePicker.date, subtitle: descriptionTextField.text ?? "")
            let dayModel = DayModel(context: coreDataStack.managedContext)
            dayModel.title = datePicker.date
            dayModel.subtitle = descriptionTextField.text
            DayFunctions.createDay(tripIndex: tripIndex!, dayModel: dayModel)
            
            if let doneSavings = doneSavings {
                doneSavings(dayModel)
            }
            dismiss(animated: true)
        }
    }
    
    func dayAlreadyExists(_ date: Date) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        if tripModel.dayModels!.contains(where: {$0.title?.mediumStyleDate() == date.mediumStyleDate()}) {
            return true
        }
        return false
    }

}
