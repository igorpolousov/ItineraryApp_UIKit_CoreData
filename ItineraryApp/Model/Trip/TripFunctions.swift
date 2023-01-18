//
//  TripFunctions.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 26.09.2022.
//

import Foundation
import UIKit
import CoreData



class TripFunctions {
    
     static var coreDataStack = CoreDataStack(modelName: "ItineraryApp")
    
    // Создать путешествие
    static func createTrip(tripModelTitle: String, tripModelImage: UIImage? = nil) {
        let tripModel = TripModel(context: coreDataStack.managedContext)
        tripModel.title = tripModelTitle
        tripModel.image = tripModelImage?.pngData()
        tripModel.id = UUID()
        ModelsData.tripModels.append(tripModel)
        coreDataStack.saveContext()
    }
    
    // Получить данные для таблицы от путешествия
    static func readTrips(completion: @escaping ()->()) {
        
        let fetchRequest: NSFetchRequest<TripModel> = TripModel.fetchRequest()
        var asyncFetchRequest: NSAsynchronousFetchRequest<TripModel>?
        asyncFetchRequest = NSAsynchronousFetchRequest<TripModel>(fetchRequest: fetchRequest) { (result: NSAsynchronousFetchResult) in
            guard let tripModels = result.finalResult else {return}
            ModelsData.tripModels = tripModels
            completion()
        }
        
        do {
            guard let asyncFetchRequest = asyncFetchRequest else {return}
            try coreDataStack.managedContext.execute(asyncFetchRequest)
        } catch let error as NSError {
            print("Unable to load data from CoreData \(error), \(error.userInfo)")
        }

    }
    
    // Получить данные для таблицы по trip id
    
    static func readTrip(by id: UUID, completion: @escaping (TripModel?) -> ()) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            let trip = ModelsData.tripModels.first(where: { $0.id == id })
            
            DispatchQueue.main.async {
                completion(trip)
            }
        }
    }
    
    // Изменить данные путешествия
    static func updateTrip(at index: Int, title: String, image: UIImage? = nil) {
        ModelsData.tripModels[index].title = title
        ModelsData.tripModels[index].image = image?.pngData()
    }
    
    // Удалить путешествие
    static func deletetrip(index: Int) {
        guard let tripToRemove = ModelsData.tripModels[index] as? TripModel else {return}
        coreDataStack.managedContext.delete(tripToRemove)
        coreDataStack.saveContext()
        ModelsData.tripModels.remove(at: index)
    }
}
