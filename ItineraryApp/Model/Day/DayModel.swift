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
    var activities = [ActivityModel]()
    
    init(title: String, subtitle: String, data: [ActivityModel]? = nil) {
        id = UUID().uuidString
        self.title = title
        self.subtitle = subtitle
        if let data {
            self.activities = data
        }
    }
    
}
