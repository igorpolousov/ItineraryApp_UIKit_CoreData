//
//  DayFunctions.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 20.11.2022.
//

import UIKit


class DayFunctions {
    static func createDay(tripIndex: Int, dayModel: DayModel, coreDataStack: CoreDataStack) {
        // Replace with real data storage

        //ModelsData.tripModels[tripIndex].dayModels?.append(dayModel)
        ModelsData.tripModels[tripIndex].addToDayModels(dayModel)
        coreDataStack.saveContext()
    }
}
