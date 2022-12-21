//
//  AddActivityViewController.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 03.12.2022.
//

import UIKit

class AddActivityViewController: UITableViewController {
 
    @IBOutlet weak var addActivityImageView: UIImageView!
    @IBOutlet weak var addActivityLabel: UILabel!
    @IBOutlet weak var activityNamePicker: UIPickerView!
    @IBOutlet weak var taskDescription: UITextField!
    @IBOutlet weak var additionalDescription: UITextField!
    @IBOutlet weak var cancelButton: PopUpViewButtons!
    @IBOutlet weak var saveButton: PopUpViewButtons!
    @IBOutlet var activityImageButton: [UIButton]!
    
    
    var tripIndex: Int!
    var tripModel: TripModel!
    var doneSavings: ((Int, ActivityModel) -> ())?
    
    // For editing activities
    var dayIndexToEdit: Int! // Needed for saving
    var activityModelToEdit: ActivityModel! // Needed for showing days in picker view
    var doneUpdating: ((Int, Int, ActivityModel) -> ())?
    
    
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addActivityLabel.font = Theme.mainFont?.withSize(30)
        addActivityLabel.setupWhiteShadow()
        
        activityNamePicker.dataSource = self
        activityNamePicker.delegate = self
        
        if let dayIndex = dayIndexToEdit, let activityModel = activityModelToEdit {
            // Update activity: Populate the pop up
            addActivityLabel.text = "Edit Activity"
            
            // Select the Day in the picker view
            activityNamePicker.selectRow(dayIndex, inComponent: 0, animated: true)
            
            // Populate the activity data
            addImageAction(activityImageButton[activityModel.activityType.rawValue])
            taskDescription.text = activityModel.title
            additionalDescription.text = activityModel.subTitle
        } else {
            // New Activity: Set default values
            addImageAction(activityImageButton[ActivityType.hotel.rawValue])
        }
    }
    
    @IBAction func done(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        guard taskDescription.hasValue, let newActivityName = taskDescription.text else { return }
        let activityType: ActivityType = getSelectedActivityType()
        let newDayIndex = activityNamePicker.selectedRow(inComponent: 0)
        
        if activityModelToEdit != nil {
            // Update Activity
            activityModelToEdit.activityType = activityType
            activityModelToEdit.title = newActivityName
            activityModelToEdit.subTitle = additionalDescription.text ?? ""
            
            ActivityFunctions.updateActivity(at: tripIndex, oldDayIndex: dayIndexToEdit, newDayIndex: newDayIndex, using: activityModelToEdit)
            if let doneUpdating = doneUpdating, let oldDayIndex = dayIndexToEdit {
                doneUpdating(oldDayIndex, newDayIndex, activityModelToEdit)
            }
            
        } else {
            // New activity
            let activityModel = ActivityModel(title: newActivityName, subTitle: additionalDescription.text ?? "", activityType: activityType)
            ActivityFunctions.createActivity(at: tripIndex, for: newDayIndex, using: activityModel)
            
            if let doneSavings = doneSavings {
                doneSavings(newDayIndex, activityModel)
            }
        }
        
        dismiss(animated: true)
    }
    
    func getSelectedActivityType() -> ActivityType {
        for (index, button) in activityImageButton.enumerated() {
            if button.tintColor == Theme.tintColor {
                return ActivityType(rawValue: index) ?? .hotel
            }
        }
        return .hotel
    }
    
    @IBAction func addImageAction(_ sender: UIButton) {
        activityImageButton.forEach({ $0.tintColor = Theme.accentColor })
        sender.tintColor = Theme.tintColor
    }
}

extension AddActivityViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tripModel.dayModels.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      return tripModel.dayModels[row].title.mediumStyleDate()
    }
    
}

