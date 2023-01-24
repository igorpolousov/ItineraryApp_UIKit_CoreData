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
    var coreDataStack: CoreDataStack!
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditMode))
        
        tableView.dataSource = self
        tableView.delegate =  self
        tableView.backgroundColor = .clear
        
        addDayActivityButton.floatingActionButtonDesign()
        
       updateTableViewWithTripData()
        
        tableRowHight = (tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.identifier)?.contentView.bounds.height ?? 0) + 5 
    }
    
    @objc func toggleEditMode(){
        navigationItem.rightBarButtonItem?.title = navigationItem.rightBarButtonItem?.title == "Edit" ? "Done" : "Edit"
        tableView.isEditing.toggle()
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
        
        if tripModel?.dayModels?.count == 0 {
            activityAction.isEnabled = false
        }
        ac.addAction(activityAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    // To add Day View Controller
    func showAddDayViewController() {
        let storyboard = UIStoryboard(name: String(describing: AddDayViewController.self), bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() as? AddDayViewController {
            vc.tripModel = tripModel
            vc.tripIndex = getTripIndex()
            vc.coreDataStack = coreDataStack
            vc.doneSavings = {[weak self] dayModel in
                guard let self = self else {return}
           
                let index = [self.tripModel?.dayModels?.index(of: dayModel) ?? 1]
                
                self.tableView.insertSections(IndexSet(index), with: UITableView.RowAnimation.automatic)
            }
            present(vc, animated: true)
        }
    }
    
    fileprivate func getTripIndex() -> Array<TripModel>.Index! {
        return ModelsData.tripModels.firstIndex(where: { tripModel in
            tripModel.id == tripId
        })
    }
    
    // To add Activity controller
    func showAddActivityViewController() {
        let storyBoard = UIStoryboard(name: String(describing: AddActivityViewController.self), bundle: nil)
        if let vc = storyBoard.instantiateInitialViewController() as? AddActivityViewController {
            vc.tripModel = tripModel
            vc.tripIndex = getTripIndex()
            vc.coreDataStack = coreDataStack
            vc.doneSavings = { [weak self] dayIndex in
                guard let self = self else { return }
                //self.tripModel?.dayModels?[dayIndex].activityModels?.append(activityModel)
                guard let dayModel = self.tripModel?.dayModels?[dayIndex] as? DayModel, let row = dayModel.activityModels?.count else {return}
                //let row = (self.tripModel?.dayModels?[dayIndex].activityModels?.count)! - 1
                let indexPath = IndexPath(row: row - 1, section: dayIndex)
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
            if let data = model.image {
                if let image = UIImage(data: data) {
                    self?.backgroundImageView.image = image
                }
            }
            self?.tableView.reloadData()
        }
    }
}

// MARK: Table view data source

extension ActivitiesViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return tripModel?.dayModels?.count ?? 0
    }
    
    // View for header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let dayModel = tripModel?.dayModels?[section] as? DayModel else {return UICollectionViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier) as! HeaderTableViewCell
        cell.setup(model: dayModel)
        return cell.contentView
    }
    
    // Number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dayModel = tripModel?.dayModels?[section] as? DayModel else {return 0}
        return dayModel.activityModels?.count ?? 0
    }
    
    // Setup cell for table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dayModel = tripModel?.dayModels?[indexPath.section] as? DayModel, let activityModel = dayModel.activityModels?[indexPath.row] as? ActivityModel else {return UITableViewCell()}
        
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
        
        guard let dayModel = tripModel?.dayModels?[indexPath.section] as? DayModel, let activityModel = dayModel.activityModels?[indexPath.row] as? ActivityModel else {return UISwipeActionsConfiguration()}
        
        let delete = UIContextualAction(style: .normal, title: "Delete") { (contextualAction, actionView, actionPerformed: @escaping (Bool) -> Void) in
      
            let ac = UIAlertController(title: "Delete", message: "Are you sure you want to delete this activity \(String(describing: activityModel.title))?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
                actionPerformed(false) // for remove row in initial position
            }
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
                // perform delete
                ActivityFunctions.deleteActivity(at: self.getTripIndex(), for: indexPath.section, using: activityModel)
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
        guard var dayModel = tripModel?.dayModels?[indexPath.section] as? DayModel, let activityModel = dayModel.activityModels?[indexPath.row] as? ActivityModel else {return UISwipeActionsConfiguration()}
        
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
            //vc.activityModelToEdit = self.tripModel?.dayModels?[indexPath.section].activityModels?[indexPath.row]
            vc.activityModelToEdit = activityModel
            // What do we want to happen after the Activity saved?
            vc.doneUpdating = { [weak self] oldDayIndex, newDayIndex, activityModel in
                guard let self = self else { return }
                
                //let oldActivityIndex = (self.tripModel?.dayModels?[oldDayIndex].activityModels?.firstIndex(of: activityModel))
                dayModel = self.tripModel?.dayModels?[oldDayIndex] as! DayModel
                let oldActivityIndex = dayModel.activityModels?.index(of: activityModel)
                if oldDayIndex == newDayIndex {
                    // 1. Update the local table data
                    //self.tripModel?.dayModels?[newDayIndex].activityModels?[oldDayIndex] = activityModel
                    dayModel = self.tripModel?.dayModels?[newDayIndex] as! DayModel
                    dayModel.insertIntoActivityModels(activityModel, at: oldDayIndex)
                    // 2. Refresh just that row
                    let indexPath = IndexPath(row: oldActivityIndex!, section: newDayIndex)
                    tableView.reloadRows(at: [indexPath], with: .right)
                } else {
                    // Activity moved to a different day
                    
                    // 1. Remove activity from local table data
                    //self.tripModel?.dayModels?[oldDayIndex].activityModels?.remove(at: oldDayIndex)
                    dayModel = self.tripModel?.dayModels?[oldDayIndex] as! DayModel
                    dayModel.removeFromActivityModels(at: oldDayIndex)
                    // 2. Insert Activity into a new  location
                    dayModel = self.tripModel?.dayModels?[newDayIndex] as! DayModel
                    guard let lastIndex = dayModel.activityModels?.count else {return}
                    //self.tripModel?.dayModels?[newDayIndex].activityModels?.insert(activityModel, at: lastIndex!)
                    dayModel.insertIntoActivityModels(activityModel, at: lastIndex)
                    // 3. Update table rows
                    tableView.performBatchUpdates({
                        tableView.deleteRows(at: [indexPath], with: .fade)
                        let insertIndexPath = IndexPath(row: lastIndex, section: newDayIndex)
                        tableView.insertRows(at: [insertIndexPath], with: .right)
                    })
                }
            }
            self.present(vc, animated: true)
            actionPerformed(true)
        }
        edit.image = UIImage(named: "pencil")
        edit.backgroundColor = Theme.swipeEditColor
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // 1. Get the Current Activity
        guard var dayModel = tripModel?.dayModels?[sourceIndexPath.section] as? DayModel, let activityModel = dayModel.activityModels?[sourceIndexPath.row] as? ActivityModel else {return}
        
        
        // 2. Delete activity from old location
        //tripModel?.dayModels?[sourceIndexPath.section].activityModels?.remove(at: sourceIndexPath.row)
        dayModel.removeFromActivityModels(at: sourceIndexPath.row)
        
        // 3. Insert Activity to a new day
        dayModel = tripModel?.dayModels?[destinationIndexPath.section] as! DayModel
        dayModel.insertIntoActivityModels(activityModel, at: destinationIndexPath.row)
        //tripModel?.dayModels?[destinationIndexPath.section].activityModels?.insert(activityModel, at: destinationIndexPath.row)
        
        // 4. Update the data store
        ActivityFunctions.reorderActivity(at: getTripIndex(), oldDayIndex: sourceIndexPath.section, newDayIndex: destinationIndexPath.section, newActivityIndex: destinationIndexPath.row, activityModel: activityModel, coreDataStack: coreDataStack)
    }
}
