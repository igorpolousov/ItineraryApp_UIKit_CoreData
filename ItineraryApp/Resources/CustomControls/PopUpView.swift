//
//  PopUpView.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 04.10.2022.
//

import UIKit

class PopUpView: UIView {

    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 10
        layer.borderColor = Theme.tintColor?.cgColor
        layer.borderWidth = 0.5
        
        backgroundColor = Theme.backgroundColor
    }

}
