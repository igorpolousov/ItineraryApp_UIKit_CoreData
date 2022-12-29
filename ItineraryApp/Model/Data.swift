//
//  Data.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 26.09.2022.
//

import Foundation


class Data {
    
    static var tripModels: [TripModel] = []
}


/*
 Core Data Entities model:
 MyTrips(TripsModel) -> Trip(TripModel) -> Day(DayModel) -> Activity(ActivityModel)
 Entities:
 1. MyTrips - managed object, contains all trips - relationship: "to-many" to Trip(TripModel)
 2. Trip - managed object, contains all days - relationships: "to-many"  to Day(DayModel), "to-one" to MyTrips
 3. Day - managed object, contains all Activities - relationships: "to-many" to Activities, "to-one" to Trip
 4. Activity - managed object - relationships: "to-one" to Day
 */
