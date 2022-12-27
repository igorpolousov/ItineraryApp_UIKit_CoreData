//
//  Trip+CoreDataProperties.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 27.12.2022.
//
//

import Foundation
import CoreData


extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: UUID?
    @NSManaged public var image: NSData? 
    @NSManaged public var day: NSOrderedSet?

}

// MARK: Generated accessors for day
extension Trip {

    @objc(insertObject:inDayAtIndex:)
    @NSManaged public func insertIntoDay(_ value: Day, at idx: Int)

    @objc(removeObjectFromDayAtIndex:)
    @NSManaged public func removeFromDay(at idx: Int)

    @objc(insertDay:atIndexes:)
    @NSManaged public func insertIntoDay(_ values: [Day], at indexes: NSIndexSet)

    @objc(removeDayAtIndexes:)
    @NSManaged public func removeFromDay(at indexes: NSIndexSet)

    @objc(replaceObjectInDayAtIndex:withObject:)
    @NSManaged public func replaceDay(at idx: Int, with value: Day)

    @objc(replaceDayAtIndexes:withDay:)
    @NSManaged public func replaceDay(at indexes: NSIndexSet, with values: [Day])

    @objc(addDayObject:)
    @NSManaged public func addToDay(_ value: Day)

    @objc(removeDayObject:)
    @NSManaged public func removeFromDay(_ value: Day)

    @objc(addDay:)
    @NSManaged public func addToDay(_ values: NSOrderedSet)

    @objc(removeDay:)
    @NSManaged public func removeFromDay(_ values: NSOrderedSet)

}

extension Trip : Identifiable {

}
