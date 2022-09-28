//
//  TripsViewController.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 27.09.2022.
//

import UIKit

class TripsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        TripFunctions.readTrip { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: TableView setup
extension TripsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.tripModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TripsTableViewCell
        cell.setup(tripModel: Data.tripModels[indexPath.row])
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
