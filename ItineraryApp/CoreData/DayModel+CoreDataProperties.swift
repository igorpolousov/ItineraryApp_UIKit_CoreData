//
//  DayModel+CoreDataProperties.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 24.01.2023.
//
//

import Foundation
import CoreData


extension DayModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayModel> {
        return NSFetchRequest<DayModel>(entityName: "DayModel")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var subtitle: String?
    @NSManaged public var title: Date?
    @NSManaged public var activityModels: NSOrderedSet?
    @NSManaged public var tripModel: TripModel?

}

// MARK: Generated accessors for activityModels
extension DayModel {

    @objc(insertObject:inActivityModelsAtIndex:)
    @NSManaged public func insertIntoActivityModels(_ value: ActivityModel, at idx: Int)

    @objc(removeObjectFromActivityModelsAtIndex:)
    @NSManaged public func removeFromActivityModels(at idx: Int)

    @objc(insertActivityModels:atIndexes:)
    @NSManaged public func insertIntoActivityModels(_ values: [ActivityModel], at indexes: NSIndexSet)

    @objc(removeActivityModelsAtIndexes:)
    @NSManaged public func removeFromActivityModels(at indexes: NSIndexSet)

    @objc(replaceObjectInActivityModelsAtIndex:withObject:)
    @NSManaged public func replaceActivityModels(at idx: Int, with value: ActivityModel)

    @objc(replaceActivityModelsAtIndexes:withActivityModels:)
    @NSManaged public func replaceActivityModels(at indexes: NSIndexSet, with values: [ActivityModel])

    @objc(addActivityModelsObject:)
    @NSManaged public func addToActivityModels(_ value: ActivityModel)

    @objc(removeActivityModelsObject:)
    @NSManaged public func removeFromActivityModels(_ value: ActivityModel)

    @objc(addActivityModels:)
    @NSManaged public func addToActivityModels(_ values: NSOrderedSet)

    @objc(removeActivityModels:)
    @NSManaged public func removeFromActivityModels(_ values: NSOrderedSet)

}

extension DayModel : Identifiable {

}


extension DayModel: Comparable {
    public static func < (lhs: DayModel, rhs: DayModel) -> Bool {
        return lhs.title! < rhs.title!
    }
    
    
}
