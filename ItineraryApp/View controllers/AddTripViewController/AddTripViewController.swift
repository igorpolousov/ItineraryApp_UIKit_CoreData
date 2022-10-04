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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
