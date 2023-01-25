//
//  TripModel+CoreDataProperties.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 24.01.2023.
//
//

import Foundation
import CoreData


extension TripModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TripModel> {
        return NSFetchRequest<TripModel>(entityName: "TripModel")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var title: String?
    @NSManaged public var dayModels: NSOrderedSet?

}

// MARK: Generated accessors for dayModels
extension TripModel {

    @objc(insertObject:inDayModelsAtIndex:)
    @NSManaged public func insertIntoDayModels(_ value: DayModel, at idx: Int)

    @objc(removeObjectFromDayModelsAtIndex:)
    @NSManaged public func removeFromDayModels(at idx: Int)

    @objc(insertDayModels:atIndexes:)
    @NSManaged public func insertIntoDayModels(_ values: [DayModel], at indexes: NSIndexSet)

    @objc(removeDayModelsAtIndexes:)
    @NSManaged public func removeFromDayModels(at indexes: NSIndexSet)

    @objc(replaceObjectInDayModelsAtIndex:withObject:)
    @NSManaged public func replaceDayModels(at idx: Int, with value: DayModel)

    @objc(replaceDayModelsAtIndexes:withDayModels:)
    @NSManaged public func replaceDayModels(at indexes: NSIndexSet, with values: [DayModel])

    @objc(addDayModelsObject:)
    @NSManaged public func addToDayModels(_ value: DayModel)

    @objc(removeDayModelsObject:)
    @NSManaged public func removeFromDayModels(_ value: DayModel)

    @objc(addDayModels:)
    @NSManaged public func addToDayModels(_ values: NSOrderedSet)

    @objc(removeDayModels:)
    @NSManaged public func removeFromDayModels(_ values: NSOrderedSet)

}

extension TripModel : Identifiable {

}
