//
//  Activity+CoreDataProperties.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 27.12.2022.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var activityType: NSObject?
    @NSManaged public var day: Day?

}

extension Activity : Identifiable {

}
