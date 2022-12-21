//
//  ActivitiesViewController.swift
//  ItineraryApp
//
//  Created by Igor Polousov on 28.10.2022.
//

import UIKit

class ActivitiesViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addDayActivityButton: UIButton!
    
    var tripId: UUID!
    var tripModel: TripModel?
    var tableRowHight: CGFloat = 0.0
    
    // MARK: ViewDidLoad
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate =  self
        tableView.backgroundColor = .clear
        
        addDayActivityButton.floatingActionButtonDesign()
        
       updateTableViewWithTripData()
        
        tableRowHight = (tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.identifier)?.contentView.bounds.height ?? 0) + 5 
    }
    
    // MARK: Floating button action - add a day or an activity
    
    @IBAction func addDayorActitvityAction(_ sender: UIButton) {
        let ac = UIAlertController(title: "What would you want to add", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Add day", style: .default,handler: { [unowned self] action in
            print("Add day")
           showAddDayViewController()
      
        }))
        
        let activityAction = UIAlertAction(title: "Add activity", style: .default, handler: {[unowned self] action in
            showAddActivityViewController()
        })
        
        if tripModel?.dayModels.count == 0 {
            activityAction.isEnabled = false
        }
        // optional check for adding activity
       // activityAction.isEnabled = tripModel!.dayModels.count > 0
        
        ac.addAction(activityAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func showAddDayViewController() {
        let storyboard = UIStoryboard(name: String(describing: AddDayViewController.self), bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() as? AddDayViewController {
            vc.tripModel = tripModel
            vc.tripIndex = getTripIndex()
            vc.doneSavings = {[weak self] dayModel in
                guard let self = self else {return}
                
              //  let index = [self.tripModel?.dayModels.count ?? 0]
                self.tripModel?.dayModels.append(dayModel)
                let index = [self.tripModel?.dayModels.firstIndex(of: dayModel) ?? 1]
                
                self.tableView.insertSections(IndexSet(index), with: UITableView.RowAnimation.automatic)
            }
            present(vc, animated: true)
        }
    }
    
    fileprivate func getTripIndex() -> Array<TripModel>.Index! {
        return Data.tripModels.firstIndex(where: { tripModel in
            tripModel.id == tripId
        })
    }
    
    func showAddActivityViewController() {
        let storyBoard = UIStoryboard(name: String(describing: AddActivityViewController.self), bundle: nil)
        if let vc = storyBoard.instantiateInitialViewController() as? AddActivityViewController {
            vc.tripModel = tripModel
            vc.tripIndex = getTripIndex()
            vc.doneSavings = { [weak self] dayIndex, activityModel in
                guard let self = self else { return }
                self.tripModel?.dayModels[dayIndex].activities.append(activityModel)
                let row = (self.tripModel?.dayModels[dayIndex].activities.count)! - 1
                let indexPath = IndexPath(row: row, section: dayIndex)
                self.tableView.insertRows(at: [indexPath], with: .right)
            }
            
            present(vc, animated: true)
        }
    }
    
    fileprivate func updateTableViewWithTripData() {
        TripFunctions.readTrip(by: tripId) {[weak self] model in
            guard self == self else { return }
            self?.tripModel = model
            
            guard let  model = model else { return }
            self?.title = model.title
            self?.backgroundImageView.image = model.image
            self?.tableView.reloadData()
        }
    }
}

// MARK: Table view data source

extension ActivitiesViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return tripModel?.dayModels.count ?? 0
    }
    
    // View for header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dayModel = (tripModel?.dayModels[section])!
        let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier) as! HeaderTableViewCell
        cell.setup(model: dayModel)
        return cell.contentView
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripModel?.dayModels[section].activities.count ?? 0
    }
    
    // Setup cell for table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let activityModel = (tripModel?.dayModels[indexPath.section].activities[indexPath.row])!
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.identifier, for: indexPath) as! ActivityTableViewCell
        cell.setup(model: activityModel)
        return cell
    }
    
    // Row hight
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableRowHight
    }
    
    // Trailing delete action
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let activityModel = tripModel!.dayModels[indexPath.section].activities[indexPath.row]
        
        let delete = UIContextualAction(style: .normal, title: "Delete") { (contextualAction, actionView, actionPerformed: @escaping (Bool) -> Void) in
            // here the code for delete action
            let ac = UIAlertController(title: "Delete", message: "Are you sure you want to delete this activity \(activityModel.title)?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                actionPerformed(false) // for remove row in initial position
            }
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
                // perform delete
                ActivityFunctions.deleteActivity(at: self.getTripIndex(), for: indexPath.section, using: activityModel)
                self.tripModel!.dayModels[indexPath.section].activities.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                actionPerformed(true)
            }
            
            ac.addAction(cancelAction)
            ac.addAction(deleteAction)
            self.present(ac, animated: true)
        }
        delete.image = UIImage(named: "delete")
        delete.backgroundColor = Theme.tintColor
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    // Leading editing action
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, actionView, actionPerformed: @escaping (Bool) -> Void) in
            // here the code for edit action
            let storyBoard = UIStoryboard(name: String(describing: AddActivityViewController.self), bundle: nil)
            let vc = storyBoard.instantiateInitialViewController() as! AddActivityViewController
            
            // Which trip we are on
            vc.tripModel = self.tripModel
            
            // Which trip are we working with
            vc.tripIndex = self.getTripIndex()
            
            // Which day we are on?
            vc.dayIndexToEdit = indexPath.section
            
            // Which activity we are editing
            vc.activityModelToEdit = self.tripModel?.dayModels[indexPath.section].activities[indexPath.row]
            
            // What do we want to happen after the Activity saved?
            vc.doneUpdating = { [weak self] oldDayIndex, newDayIndex, activityModel in
                guard let self = self else { return }
                
                let oldActivityIndex = (self.tripModel?.dayModels[oldDayIndex].activities.firstIndex(of: activityModel))
                if oldDayIndex == newDayIndex {
                    // 1. Update the local table data
                    self.tripModel?.dayModels[newDayIndex].activities[oldDayIndex] = activityModel
                    // 2. Refresh just that row
                    let indexPath = IndexPath(row: oldActivityIndex!, section: newDayIndex)
                    tableView.reloadRows(at: [indexPath], with: .right)
                } else {
                    // Activity moved to a different day
                    
                    // 1. Remove activity from local table data
                    self.tripModel?.dayModels[oldDayIndex].activities.remove(at: oldDayIndex)
                    // 2. Insert Activity into a new  location
                    let lastIndex = (self.tripModel?.dayModels[newDayIndex].activities.count)
                    self.tripModel?.dayModels[newDayIndex].activities.insert(activityModel, at: lastIndex!)
                    // 3. Update table rows
                    tableView.performBatchUpdates {
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        let insertIndexPath = IndexPath(row: lastIndex!, section: newDayIndex)
                        tableView.insertRows(at: [insertIndexPath], with: .right)
                    }
                }
            }
            self.present(vc, animated: true)
            actionPerformed(true)
        }
        edit.image = UIImage(named: "pencil")
        edit.backgroundColor = Theme.swipeEditColor
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
}
