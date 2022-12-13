//
//  AddActivityViewController.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 03.12.2022.
//

import UIKit

class AddActivityViewController: UIViewController {
  
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addActivityLabel.font = Theme.mainFont?.withSize(30)
        addActivityLabel.setupWhiteShadow()
        
        activityNamePicker.dataSource = self
        activityNamePicker.delegate = self
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let activityType: ActivityType = getSelectedActivityType()
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
