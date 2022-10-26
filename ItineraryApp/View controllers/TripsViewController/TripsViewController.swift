//
//  TripsViewController.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 27.09.2022.
//

import UIKit

class TripsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.backgroundColor = Theme.backgroundColor
        tableView.backgroundColor = Theme.backgroundColor
        
        addButton.floatingActionButtonDesign()
        
        
        TripFunctions.readTrip { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: Table source
    
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
            
            let trip = Data.tripModels[indexPath.row]
            
            let ac = UIAlertController(title: "Delete trip", message: "Are you sure you want to delete \(trip.title)?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler: { action in
                actionPerformed(false)
            }))
            ac.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                // Perform delete
                TripFunctions.deletetrip(index: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                actionPerformed(true)
            }))
            self.present(ac, animated: true)
        }
        
        // Картинка на белом фоне: render as: template image, resizing: preserve vector data
        delete.image = UIImage(named: "delete")
        delete.backgroundColor = Theme.tintColor
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddTripViewController" {
            let popUp = segue.destination as! AddTripViewController
            popUp.doneSavings = { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}
