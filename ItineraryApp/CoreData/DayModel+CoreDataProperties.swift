//
//  DayModel+CoreDataProperties.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 18.01.2023.
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
    @NSManaged public var activityModels: [ActivityModel]?
    @NSManaged public var tripModel: TripModel?

}

// MARK: Generated accessors for activityModels
extension DayModel {

    @objc(addActivityModelsObject:)
    @NSManaged public func addToActivityModels(_ value: ActivityModel)

    @objc(removeActivityModelsObject:)
    @NSManaged public func removeFromActivityModels(_ value: ActivityModel)

    @objc(addActivityModels:)
    @NSManaged public func addToActivityModels(_ values: NSSet)

    @objc(removeActivityModels:)
    @NSManaged public func removeFromActivityModels(_ values: NSSet)

}

extension DayModel : Identifiable {

}
