//
//  ActivityFunctions.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 13.12.2022.
//

import Foundation

class ActivityFunctions {
    static func createActivity(at tripIndex: Int, for dayIndex: Int, using activityModel: ActivityModel) {
        // Replace with real data storage
        Data.tripModels[tripIndex].dayModels[dayIndex].activities.append(activityModel)
    }
    
    static func deleteActivity(at tripIndex: Int, for dayIndex: Int, using activityModel: ActivityModel) {
        // Replace with real data storage
        var dayModel = Data.tripModels[tripIndex].dayModels[dayIndex]
        if let index = dayModel.activities.firstIndex(of: activityModel) {
            dayModel.activities.remove(at: index)
        }
    }
    
}
