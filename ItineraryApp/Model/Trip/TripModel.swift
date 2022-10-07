//
//  TripModel.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 26.09.2022.
//

import UIKit


class TripModel {
    
    var title: String
    let id: UUID // Номер путешествия нужен для того чтобы отличать два поста с одинкаовыми названиями
    var image: UIImage?
    
    
    init(title: String, image: UIImage? =  nil) {
        self.title = title
        self.image = image
        id = UUID()
    }
}
