//
//  UITextFieldExtension.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 20.11.2022.
//

import UIKit

extension UITextField {
     var hasValue: Bool {
         guard text == "" else {return true}
         let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
         imageView.image = UIImage(named: "warning")
         rightViewMode = .unlessEditing
         rightView = imageView
         return false
         
    }
}
