//
//  TripFunctions.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 26.09.2022.
//

import Foundation


class TripFunctions {
    
    // Создать путешествие
    static func createTrip(tripModel: TripModel) {
        
    }
    
    // Получить данные для таблицы от путешествия
    static func readTrip() {
        // Fake data for building interface model
        if Data.tripModels.count == 0 {
            Data.tripModels.append(TripModel(title: "Trip to Bali!"))
            Data.tripModels.append(TripModel(title: "Mexico"))
            Data.tripModels.append(TripModel(title: "Russian trip"))
        }
        
    }
    
    // Изменить данные путешествия
    static func updateTrip(tripModel: TripModel) {
        
    }
    
    // Удалить путешествие
    static func deletetrip(tripModel: TripModel) {
        
    }
}
