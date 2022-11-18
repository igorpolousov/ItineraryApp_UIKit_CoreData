//
//  UITableViewCellExtension.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 18.11.2022.
//

import UIKit

extension UITableViewCell {
    /// Return class name as string for cell identifier
    class var identifier: String {
        return String(describing: self)
    }
}
