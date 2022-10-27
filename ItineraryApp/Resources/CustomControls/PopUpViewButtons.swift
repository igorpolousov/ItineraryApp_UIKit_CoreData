//
//  PopUpViewButtons.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 04.10.2022.
//

import UIKit

class PopUpViewButtons: UIButton {
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = frame.height / 2
        
        backgroundColor = Theme.tintColor
        tintColor = .white
    }

}
