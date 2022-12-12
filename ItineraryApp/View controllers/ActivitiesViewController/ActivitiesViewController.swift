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
            vc.tripIndex = Data.tripModels.firstIndex(where: { tripModel in
                tripModel.id == tripId
            })
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
    
    func showAddActivityViewController() {
        let storyBoard = UIStoryboard(name: String(describing: AddActivityViewController.self), bundle: nil)
        if let vc = storyBoard.instantiateInitialViewController() as? AddActivityViewController {
            vc.tripModel = tripModel
            vc.tripIndex = Data.tripModels.firstIndex(where: { tripModel in
                tripModel.id == tripId
            })
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
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tripModel?.dayModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dayModel = (tripModel?.dayModels[section])!
        let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.identifier) as! HeaderTableViewCell
        cell.setup(model: dayModel)
        return cell.contentView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripModel?.dayModels[section].activities.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let activityModel = (tripModel?.dayModels[indexPath.section].activities[indexPath.row])!
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.identifier, for: indexPath) as! ActivityTableViewCell
        cell.setup(model: activityModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableRowHight
    }
    
    
}
