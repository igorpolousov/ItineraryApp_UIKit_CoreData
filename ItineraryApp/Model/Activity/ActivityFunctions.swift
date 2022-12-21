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
    
    static func updateActivity(at tripIndex: Int, oldDayIndex: Int, newDayIndex: Int, using activityModel: ActivityModel) {
        // replace with real data store here
        if oldDayIndex != newDayIndex {
            //move activity to a different day
            let lastIndex = Data.tripModels[tripIndex].dayModels[newDayIndex].activities.count
            reorderActivity(at: tripIndex, oldDayIndex: oldDayIndex, newDayIndex: newDayIndex, newActivityIndex: lastIndex, activityModel: activityModel)
        } else {
            //update activity in the same day
            let dayModel = Data.tripModels[tripIndex].dayModels[oldDayIndex]
            let activityIndex = (dayModel.activities.firstIndex(of: activityModel))
            Data.tripModels[tripIndex].dayModels[newDayIndex].activities[activityIndex!] = activityModel
        }
    }
    
    static func reorderActivity(at tripIndex: Int, oldDayIndex: Int, newDayIndex: Int, newActivityIndex: Int, activityModel: ActivityModel) {
        // Replace with real data store
        
        // 1. Remove activity from old location
        let oldDayModel = Data.tripModels[tripIndex].dayModels[oldDayIndex]
        let oldActivityIndex = (oldDayModel.activities.firstIndex(of: activityModel))
        Data.tripModels[tripIndex].dayModels[newDayIndex].activities.remove(at: oldDayIndex)
        
        // 2. Insert activity to a new location
        Data.tripModels[tripIndex].dayModels[newDayIndex].activities.insert(activityModel, at: newDayIndex)
    }
    
}
