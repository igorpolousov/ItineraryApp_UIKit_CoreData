//
//  MockData.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 03.11.2022.
//

import UIKit

class MockData {
    
    static func createMockTripData() -> [TripModel] {
        var mockTrips = [TripModel]()
        // DownLoad and add images to app
            mockTrips.append(TripModel(title: "Минеральные воды",image: UIImage(named: "min"), dayModels: createMockDayModelData()))
            mockTrips.append(TripModel(title: "Московская область", image: UIImage(named: "mos")))
            mockTrips.append(TripModel(title: "Ярославская область", image: UIImage(named: "yar")))
            mockTrips.append(TripModel(title: "Саповелер", image: UIImage(named: "sapoveler")))
        return mockTrips
    }
    
    static func createMockDayModelData() -> [DayModel] {
        var dayModels = [DayModel]()
        dayModels.append(DayModel(title: Date().add(days: 1), subtitle: "Train",data: createMockActitvityData()))
        dayModels.append(DayModel(title: Date().add(days: 2), subtitle: "Constractions", data: createMockActitvityData()))
        dayModels.append((DayModel(title: Date().add(days: 3), subtitle: "Agriculture", data: createMockActitvityData())))
        return dayModels
    }
    
    static func createMockActitvityData() -> [ActivityModel] {
        var mockActivities = [ActivityModel]()
        mockActivities.append(ActivityModel(title: "Take ticket", subTitle: "Train", activityType: .train))
        mockActivities.append(ActivityModel(title: "Teke suburban ticket", subTitle: "Suburban train", activityType: .suburbanTrain))
        mockActivities.append(ActivityModel(title: "Book a hotel", subTitle: "if needed", activityType: .hotel))
        mockActivities.append(ActivityModel(title: "Order taxi", subTitle: "phone number", activityType: .auto))
        return mockActivities
    }
}
