//
//  AddTripViewController.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 04.10.2022.
//

import UIKit
import Photos

class AddTripViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tripTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    // Call back function for sending data to another class "Trips view controller"
    var doneSavings: (()->())?
    var tripIndexToEdit: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.font = Theme.mainFont?.withSize(26)
        
        addPhotoButton.tintColor = Theme.tintColor
        addPhotoButton.setImage(UIImage(named: "camera"), for: .normal)
        
        imageView.layer.cornerRadius = 10
        
        // Drop shadow title
        titleLabel.setupWhiteShadow()
       
        if let index = tripIndexToEdit {
            let trip = Data.tripModels[index]
            tripTextField.text = trip.title
            imageView.image = trip.image
            titleLabel.text = "Edit Trip"
        }
  
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        tripTextField.rightViewMode = .never
        
        guard tripTextField.text != "", let text = tripTextField.text  else {
            //Show warning image if no text were entered
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = UIImage(named: "warning")
            tripTextField.rightViewMode = .unlessEditing
            tripTextField.rightView = imageView
            
            // Alternatives
            
            // Чтобы показать пользователю, что он не ввёл текс можно изменить цвет поля
            //tripTextField.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1) // for adding such a color use = #colorLiteral(
            
            // Сделать цвет рамки другого цвета
//            tripTextField.layer.borderColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
//            tripTextField.layer.borderWidth = 1
//            tripTextField.layer.cornerRadius = 4
//            tripTextField.rightViewMode = .always
            
            return
        }
        if let index = tripIndexToEdit {
            TripFunctions.updateTrip(at: index, title: text, image: imageView.image)
        } else {
            TripFunctions.createTrip(tripModel: TripModel(title: text, image: imageView.image))
        }
        
        if let doneSavings = doneSavings {
            doneSavings()
        }
        dismiss(animated: true)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func addPhoto(_ sender: UIButton) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            PHPhotoLibrary.requestAuthorization { (status) in
                DispatchQueue.main.async {
                    switch status {
                    case .authorized :
                        let myPickerController = UIImagePickerController()
                        myPickerController.allowsEditing = true
                        myPickerController.sourceType = .photoLibrary
                        myPickerController.delegate = self
                        self.present(myPickerController,animated: true)
                    default:
                        break
                        
                    }
                }
            }
        }
    }
}

extension AddTripViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            imageView.contentMode = .scaleAspectFill
            imageView.image = image
        } else if let image = info[.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFill
            imageView.image = image
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
