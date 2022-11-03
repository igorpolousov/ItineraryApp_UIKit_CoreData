//
//  TripModel.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 26.09.2022.
//

import UIKit


struct TripModel {
    
    var title: String
    let id: UUID // Номер путешествия нужен для того чтобы отличать два поста с одинкаовыми названиями
    var image: UIImage?
    var dayModels: [DayModel] = []
    
    
    init(title: String, image: UIImage? =  nil, dayModels: [DayModel]? = nil){
        self.title = title
        self.image = image
        id = UUID()
        if let dayModels {
            self.dayModels = dayModels
        }
    }
}
