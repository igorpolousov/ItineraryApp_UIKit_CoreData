//
//  TripFunctions.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 26.09.2022.
//

import UIKit
import CoreData



class TripFunctions {
    
    // Create trip
    static func createTrip(tripModelTitle: String, tripModelImage: UIImage? = nil, coreDataStack: CoreDataStack) {
        let tripModel = TripModel(context: coreDataStack.managedContext)
        tripModel.title = tripModelTitle
        tripModel.image = tripModelImage?.pngData()
        tripModel.id = UUID()
        ModelsData.tripModels.append(tripModel)
        coreDataStack.saveContext()
    }
    
    // Fetch trips form Core Data
    static func readTrips(coreDataStack: CoreDataStack, completion: @escaping ()->()) {
        
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
    
    // Get trip data form table by trip id
    
    static func readTrip(by id: UUID, completion: @escaping (TripModel?) -> ()) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            let trip = ModelsData.tripModels.first(where: { $0.id == id })
            
            DispatchQueue.main.async {
                completion(trip)
            }
        }
    }
    
    // Update trip data
    static func updateTrip(at index: Int, title: String, image: UIImage? = nil, coreDataStack: CoreDataStack) {
        ModelsData.tripModels[index].title = title
        ModelsData.tripModels[index].image = image?.pngData()
        coreDataStack.saveContext()
    }
    
    // Delete trip
    static func deletetrip(index: Int, coreDataStack: CoreDataStack) {
        let tripToRemove = ModelsData.tripModels[index]
        coreDataStack.managedContext.delete(tripToRemove)
        coreDataStack.saveContext()
        ModelsData.tripModels.remove(at: index)
    }
}
