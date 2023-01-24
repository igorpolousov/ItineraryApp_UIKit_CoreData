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
        guard let sortedDays = ModelsData.tripModels[tripIndex].dayModels?.sorted(by: { dayModel1, dayModel2 in
            let dayModel1 = dayModel1 as? DayModel
            let dayModel2 = dayModel2 as? DayModel
            return (dayModel1?.title)! < (dayModel2?.title)!
        }) else {return}
        ModelsData.tripModels[tripIndex].dayModels = NSOrderedSet(array: sortedDays)
        coreDataStack.saveContext()
    }
}
