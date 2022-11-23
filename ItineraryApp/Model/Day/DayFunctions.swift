//
//  DayFunctions.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 20.11.2022.
//

import Foundation


class DayFunctions {
    static func createDay(tripIndex: Int, dayModel: DayModel) {
        // Replace with real data storage
        Data.tripModels[tripIndex].dayModels.append(dayModel)
    }
}
