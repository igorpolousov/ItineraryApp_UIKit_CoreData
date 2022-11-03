//
//  ActivityModel.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 03.11.2022.
//

import UIKit

struct ActivityModel {
    var id: String!
    var title: String
    var subTitle: String
    var activityType: ActivityType
    var photo: UIImage?
    
    init(title: String, subTitle: String, activityType: ActivityType, photo: UIImage? = nil) {
        id = UUID().uuidString
        self.title = title
        self.subTitle = subTitle
        self.activityType = activityType
        self.photo = photo
    }
}
