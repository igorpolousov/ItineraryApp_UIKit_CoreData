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
        ModelsData.tripModels[tripIndex].dayModels?[dayIndex].activityModels?.append(activityModel)
    }
    
    static func deleteActivity(at tripIndex: Int, for dayIndex: Int, using activityModel: ActivityModel) {
        // Replace with real data storage
        var dayModel = ModelsData.tripModels[tripIndex].dayModels?[dayIndex]
        if let index = dayModel?.activityModels?.firstIndex(of: activityModel) {
            dayModel?.activityModels?.remove(at: index)
        }
    }
    
    static func updateActivity(at tripIndex: Int, oldDayIndex: Int, newDayIndex: Int, using activityModel: ActivityModel) {
        // replace with real data store here
        if oldDayIndex != newDayIndex {
            //move activity to a different day
            let lastIndex = ModelsData.tripModels[tripIndex].dayModels?[newDayIndex].activityModels?.count
            reorderActivity(at: tripIndex, oldDayIndex: oldDayIndex, newDayIndex: newDayIndex, newActivityIndex: lastIndex!, activityModel: activityModel)
        } else {
            //update activity in the same day
            let dayModel = ModelsData.tripModels[tripIndex].dayModels?[oldDayIndex]
            let activityIndex = (dayModel?.activityModels?.firstIndex(of: activityModel))
            ModelsData.tripModels[tripIndex].dayModels?[newDayIndex].activityModels?[activityIndex!] = activityModel
        }
    }
    
    static func reorderActivity(at tripIndex: Int, oldDayIndex: Int, newDayIndex: Int, newActivityIndex: Int, activityModel: ActivityModel) {
        // Replace with real data store
        
        // 1. Remove activity from old location
        let oldDayModel = ModelsData.tripModels[tripIndex].dayModels?[oldDayIndex]
        let oldActivityIndex = (oldDayModel?.activityModels?.firstIndex(of: activityModel))!
        ModelsData.tripModels[tripIndex].dayModels?[newDayIndex].activityModels?.remove(at: oldActivityIndex)
        
        // 2. Insert activity to a new location
        ModelsData.tripModels[tripIndex].dayModels?[newDayIndex].activityModels?.insert(activityModel, at: newDayIndex)
    }
    
}
