//
//  ActivityModel+CoreDataProperties.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 18.01.2023.
//
//

import Foundation
import CoreData


extension ActivityModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivityModel> {
        return NSFetchRequest<ActivityModel>(entityName: "ActivityModel")
    }

    @NSManaged public var activityType: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?
    @NSManaged public var dayModels: DayModel?

}

extension ActivityModel : Identifiable {

}
