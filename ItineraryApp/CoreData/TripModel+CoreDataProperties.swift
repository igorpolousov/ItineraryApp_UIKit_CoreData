//
//  TripModel+CoreDataProperties.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 18.01.2023.
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
    @NSManaged public var dayModels: [DayModel]? // I want array

}

// MARK: Generated accessors for dayModels
extension TripModel {

    @objc(addDayModelsObject:)
    @NSManaged public func addToDayModels(_ value: DayModel)

    @objc(removeDayModelsObject:)
    @NSManaged public func removeFromDayModels(_ value: DayModel)

    @objc(addDayModels:)
    @NSManaged public func addToDayModels(_ values: NSSet)

    @objc(removeDayModels:)
    @NSManaged public func removeFromDayModels(_ values: NSSet)

}

extension TripModel : Identifiable {

}
