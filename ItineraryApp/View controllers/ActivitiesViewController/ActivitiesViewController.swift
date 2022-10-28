//
//  ActivitiesViewController.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 28.10.2022.
//

import UIKit

class ActivitiesViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    var backgroundImage: UIImage?
    var tripName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let backgroundImage {
            backgroundImageView.image = backgroundImage
        }
        if let tripName {
            title = tripName
        }
        
    }
    

}
