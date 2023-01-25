//
//  TripsViewController.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 27.09.2022.
//

import UIKit
import CoreData

class TripsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var helpView: UIVisualEffectView!
    
    var tripIndexToEdit: Int?
    var helpViewDefaultsKey = "seenTripHelp"
    
    lazy var coreDataStack = CoreDataStack(modelName: "ItineraryApp")
    
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Trips"
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.barTintColor = Theme.backgroundColor
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.backgroundColor = Theme.backgroundColor
        tableView.backgroundColor = Theme.backgroundColor
        
        addButton.floatingActionButtonDesign()
        
        //getTripData()  option 1 to show data before animation
        
        let radians = CGFloat(200 * Double.pi / 180)
        
        UIView.animate(withDuration: 1.2, delay: 0,options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.logoImageView.alpha = 0
            self.logoImageView.transform = CGAffineTransform(rotationAngle: radians)
                .scaledBy(x: 3, y: 3) // 3 is multiplyer here
            let yRotation = CATransform3DMakeRotation(radians, 0, radians, 0)
            self.logoImageView.layer.transform = CATransform3DConcat(self.logoImageView.layer.transform, yRotation)
        }) { success in
            self.getTripData() // option 2 to show data after animation
        }
    }
    
    fileprivate func getTripData() {
        TripFunctions.readTrips(coreDataStack: coreDataStack) { [unowned self] in
            self.tableView.reloadData()
            
            if ModelsData.tripModels.count > 0 {
                if UserDefaults.standard.bool(forKey: helpViewDefaultsKey) ==  false {
                    view.addSubview(helpView)
                    helpView.frame = view.frame
                }
            }
        }
    }
    
    @IBAction func closeHelpView(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.helpView.alpha = 0
        } completion: { (success) in
            self.helpView.removeFromSuperview()
            UserDefaults.standard.set(true, forKey: self.helpViewDefaultsKey)
        }
    }
    
    // MARK: Table source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelsData.tripModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TripsTableViewCell.identifier, for: indexPath) as! TripsTableViewCell
        cell.setup(tripModel: ModelsData.tripModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trip = ModelsData.tripModels[indexPath.row]
        let storyBoard = UIStoryboard(name: "ActivitiesViewController", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: String(describing: ActivitiesViewController.self)) as? ActivitiesViewController {
            vc.tripId = trip.id
            vc.coreDataStack = coreDataStack
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, actionView, actionPerformed: @escaping (Bool) -> Void) in
            let trip = ModelsData.tripModels[indexPath.row]
            let ac = UIAlertController(title: "Delete trip", message: "Are you sure you want to delete \(trip.title ?? "")?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel,handler: { action in
                actionPerformed(false)
            }))
            ac.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                // Perform delete
                TripFunctions.deletetrip(index: indexPath.row, coreDataStack: self.coreDataStack)
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
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
      
        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
            self.tripIndexToEdit = indexPath.row
            self.performSegue(withIdentifier: "toAddTripViewController", sender: nil)
            actionPerformed(true)
            
        }
        edit.image = UIImage(named: "pencil")
        edit.backgroundColor = Theme.swipeEditColor
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddTripViewController" {
            let popUp = segue.destination as! AddTripViewController
            popUp.tripIndexToEdit = self.tripIndexToEdit
            popUp.coreDataStack = coreDataStack
            popUp.doneSavings = { [weak self] in
                self?.tableView.reloadData()
            }
            tripIndexToEdit = nil
        }
    }
}
