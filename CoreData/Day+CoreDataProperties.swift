//
//  Day+CoreDataProperties.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 30.12.2022.
//
//

import Foundation
import CoreData


extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var trip: Trip?
    @NSManaged public var activity: NSOrderedSet?

}

// MARK: Generated accessors for activity
extension Day {

    @objc(insertObject:inActivityAtIndex:)
    @NSManaged public func insertIntoActivity(_ value: Activity, at idx: Int)

    @objc(removeObjectFromActivityAtIndex:)
    @NSManaged public func removeFromActivity(at idx: Int)

    @objc(insertActivity:atIndexes:)
    @NSManaged public func insertIntoActivity(_ values: [Activity], at indexes: NSIndexSet)

    @objc(removeActivityAtIndexes:)
    @NSManaged public func removeFromActivity(at indexes: NSIndexSet)

    @objc(replaceObjectInActivityAtIndex:withObject:)
    @NSManaged public func replaceActivity(at idx: Int, with value: Activity)

    @objc(replaceActivityAtIndexes:withActivity:)
    @NSManaged public func replaceActivity(at indexes: NSIndexSet, with values: [Activity])

    @objc(addActivityObject:)
    @NSManaged public func addToActivity(_ value: Activity)

    @objc(removeActivityObject:)
    @NSManaged public func removeFromActivity(_ value: Activity)

    @objc(addActivity:)
    @NSManaged public func addToActivity(_ values: NSOrderedSet)

    @objc(removeActivity:)
    @NSManaged public func removeFromActivity(_ values: NSOrderedSet)

}

extension Day : Identifiable {

}
