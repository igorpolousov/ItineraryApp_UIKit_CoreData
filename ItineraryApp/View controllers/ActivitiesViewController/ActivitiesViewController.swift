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
    
    
    var tripId: UUID!
    var tripModel: TripModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate =  self
        tableView.backgroundColor = .clear
        
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = tripModel?.dayModels[section].title ?? ""
        let subtitle = tripModel?.dayModels[section].subtitle ?? ""
        return "\(title) \(subtitle)"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripModel?.dayModels[section].activities.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text = tripModel?.dayModels[indexPath.section].activities[indexPath.row].title
        cell.detailTextLabel?.text = tripModel?.dayModels[indexPath.section].activities[indexPath.row].subTitle
        return cell
    }
    
    
}
