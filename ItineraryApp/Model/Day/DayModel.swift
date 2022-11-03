//
//  DayModel.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 03.11.2022.
//

import UIKit


struct DayModel {
    
    var id: String!
    var title: String = ""
    var subtitle: String = ""
    var activitiesModel = [ActivityModel]()
    
    init(title: String, subtitle: String, activitiesModel: [ActivityModel]?) {
        id = UUID().uuidString
        self.title = title
        self.subtitle = subtitle
        if let activitiesModel {
            self.activitiesModel = activitiesModel
        }
    }
    
}
