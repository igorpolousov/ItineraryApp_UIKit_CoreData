//
//  UIViewExtensions.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 28.09.2022.
//

import UIKit

extension UIView {
    func applyDesign() {
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 10
    }
}

