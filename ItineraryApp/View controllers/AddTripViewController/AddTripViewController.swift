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
        tripTextField.rightViewMode = .never
        
        guard tripTextField.text != "", let text = tripTextField.text  else {
                      //Show warning image if no text were entered
//            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
//            imageView.image = UIImage(named: "warning")
//            tripTextField.rightView = imageView
            
            // Alternatives
            
            // Чтобы показать пользователю, что он не ввёл текс можно изменить цвет поля
            //tripTextField.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1) // for adding such a color use = #colorLiteral(
            
            // Сделать цвет рамки другого цвета
            tripTextField.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            tripTextField.layer.borderWidth = 1
            tripTextField.layer.cornerRadius = 4
            tripTextField.rightViewMode = .always
        
            return
        }
        
        TripFunctions.createTrip(tripModel: TripModel(title: text))
                                 
        if let doneSavings = doneSavings {
            doneSavings()
        }
        dismiss(animated: true)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
