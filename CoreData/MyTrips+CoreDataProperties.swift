//
//  MyTrips+CoreDataProperties.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 30.12.2022.
//
//

import Foundation
import CoreData


extension MyTrips {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyTrips> {
        return NSFetchRequest<MyTrips>(entityName: "MyTrips")
    }

    @NSManaged public var name: String?
    @NSManaged public var trip: Trip?

}

extension MyTrips : Identifiable {

}
