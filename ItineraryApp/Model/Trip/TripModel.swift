//
//  TripModel.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 26.09.2022.
//

import UIKit


//struct TripModel {
//    
//    var title: String
//    let id: UUID // Номер путешествия нужен для того чтобы отличать два поста с одинкаовыми названиями
//    var image: UIImage?
//    var dayModels: [DayModel] = [] {
//        didSet {
//            // Called when a new value is assigned to dayModels
//            /*
//            dayModels = dayModels.sorted(by: { dayModel_1, dayModel_2 in
//                dayModel_1.title < dayModel_2.title
//                
//                 dayMOdels = dayMOdels.sorted(by: {$0.title < $1.title })
//                 */
//            dayModels = dayModels.sorted(by: <)
//        }
//    }
//    
//    
//    init(title: String, image: UIImage? =  nil, dayModels: [DayModel]? = nil){
//        self.title = title
//        self.image = image
//        id = UUID()
//        if let dayModels {
//            self.dayModels = dayModels
//        }
//    }
//}
