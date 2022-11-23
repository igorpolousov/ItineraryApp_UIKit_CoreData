//
//  DateExtension.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 23.11.2022.
//

import Foundation

extension Date {
    func add(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: Date())!
    }
}
