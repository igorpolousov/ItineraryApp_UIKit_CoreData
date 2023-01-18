//
//  NSSetExtension.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 18.01.2023.
//

import Foundation

extension NSSet {
    func toArray<T>() -> [T] {
        let array = self.map({$0 as! T})
        return array
    }
}
