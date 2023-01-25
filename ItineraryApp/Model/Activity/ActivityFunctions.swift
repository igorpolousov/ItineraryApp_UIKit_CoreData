//
//  ActivityFunctions.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 13.12.2022.
//

import UIKit
import CoreData

class ActivityFunctions {
    static func createActivity(at tripIndex: Int, for dayIndex: Int, activityTitle: String, activitySubtitle: String, activityType: Int32, coreDataStack: CoreDataStack ) {
        
        let activityModel = ActivityModel(context: coreDataStack.managedContext)
        activityModel.title = activityTitle
        activityModel.subtitle = activitySubtitle
        activityModel.activityType = activityType
        let dayModel = ModelsData.tripModels[tripIndex].dayModels?[dayIndex] as? DayModel
        dayModel?.addToActivityModels(activityModel)
        coreDataStack.saveContext()
        
    }
    
    static func deleteActivity(at tripIndex: Int, for dayIndex: Int, using activityModel: ActivityModel, coreDataStack: CoreDataStack) {
        let dayModel = ModelsData.tripModels[tripIndex].dayModels?[dayIndex] as? DayModel
        dayModel?.removeFromActivityModels(activityModel)
        coreDataStack.saveContext()
        
    }
    
    static func updateActivity(at tripIndex: Int, oldDayIndex: Int, newDayIndex: Int, using activityModel: ActivityModel, coreDataStack: CoreDataStack) {

        if oldDayIndex != newDayIndex {
            //move activity to a different day
             guard let dayModel = ModelsData.tripModels[tripIndex].dayModels?[newDayIndex] as? DayModel,
                   let lastIndex = dayModel.activityModels?.count else {return}
            reorderActivity(at: tripIndex, oldDayIndex: oldDayIndex, newDayIndex: newDayIndex, newActivityIndex: lastIndex, activityModel: activityModel, coreDataStack: coreDataStack)
        } else {
            //update activity in the same day
            guard let dayModel = ModelsData.tripModels[tripIndex].dayModels?[oldDayIndex] as? DayModel,
                  let activityIndex = dayModel.activityModels?.index(of: activityModel) else {return}
            dayModel.replaceActivityModels(at: activityIndex, with: activityModel)
            coreDataStack.saveContext()
        }
    }
    
    static func reorderActivity(at tripIndex: Int, oldDayIndex: Int, newDayIndex: Int, newActivityIndex: Int, activityModel: ActivityModel, coreDataStack: CoreDataStack) {
        
        // 1. Remove activity from old location
        guard let oldDayModel = ModelsData.tripModels[tripIndex].dayModels?[oldDayIndex] as? DayModel,
              let oldActivityIndex = oldDayModel.activityModels?.index(of: activityModel) else {return}
        //guard let newDayModel = ModelsData.tripModels[tripIndex].dayModels?[newDayIndex] as? DayModel else {return}
        //newDayModel.removeFromActivityModels(at: oldActivityIndex)
        oldDayModel.removeFromActivityModels(at: oldActivityIndex)
        
        // 2. Insert activity to a new location
        guard let dayModel = ModelsData.tripModels[tripIndex].dayModels?[newDayIndex] as? DayModel else {return}
        //dayModel.insertIntoActivityModels(activityModel, at: newDayIndex)
        dayModel.addToActivityModels(activityModel)
        coreDataStack.saveContext()
    }
    
}
