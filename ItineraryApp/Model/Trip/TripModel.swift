//
//  TripModel.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 26.09.2022.
//

import Foundation


class TripModel {
    
    var title: String
    var id: String // Номер путешествия нужен для того чтобы отличать два поста с одинкаовыми названиями
    
    init(title: String) {
        self.title = title
        id = UUID().uuidString
    }
}
