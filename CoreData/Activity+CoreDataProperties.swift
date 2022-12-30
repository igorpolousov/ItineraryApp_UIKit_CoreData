//
//  Activity+CoreDataProperties.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 30.12.2022.
//
//

import Foundation
import CoreData


extension Activity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Activity> {
        return NSFetchRequest<Activity>(entityName: "Activity")
    }

    @NSManaged public var title: String?
    @NSManaged public var subttitle: String?
    @NSManaged public var id: String?
    @NSManaged public var activityType: NSObject?
    @NSManaged public var day: Day?

}

extension Activity : Identifiable {

}
