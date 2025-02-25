//
//  ViewController.swift
//  TripPlanner
//
//  Created by Noah Woodward on 4/26/19.
//  Copyright © 2019 Noah Woodward. All rights reserved.
//

import UIKit
import CoreData

class TripsHomeViewController: UITableViewController {
    var persistenceStack = CoreDataStack()
    lazy var fetchedResultsController: NSFetchedResultsController<Trip> = {
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        let searchDescriptorName = NSSortDescriptor(key: "tripName", ascending: true)
        fetchRequest.sortDescriptors = [searchDescriptorName]
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: persistenceStack.managedContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        return fetchedResultsController
    }()
    // MARK: METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        loadData()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tripCell")
        tableView.reloadData()
    }
    private func loadData() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    internal func setupNavBar() {
        let addNavButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.add,
            target: self,
            action: #selector(addTripButtonPressed))
        let settingsNavButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                                target: self,
                                                action: #selector(settingsButtonPressed))
        self.navigationItem.setRightBarButton(addNavButton, animated: false)
        self.navigationItem.setLeftBarButton(settingsNavButton, animated: false)
        self.title = "Planned Trips"
    }
    @objc private func settingsButtonPressed() {
        let settingsVC = SettingsViewController()
        self.navigationController?.pushViewController(settingsVC, animated: true)
        
    }
    @objc private func addTripButtonPressed() {
        let addTripVC = AddTripViewController()
        addTripVC.persistenceStack = persistenceStack
        let navigationVC = UINavigationController()
        navigationVC.viewControllers = [addTripVC]
        self.present(navigationVC, animated: false, completion: nil)
    }
}
extension TripsHomeViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo =
            fetchedResultsController.sections?[section] else {
                return 0
        }
        return sectionInfo.numberOfObjects
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
        let cellTrip = fetchedResultsController.object(at: indexPath)
        cell.textLabel!.text = cellTrip.tripName!
        return cell
    }
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            persistenceStack.deleteTrip(trip: fetchedResultsController.object(at: indexPath))
            loadData()
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trip = fetchedResultsController.object(at: indexPath)
        let waypointsVC = WaypointViewController()
        waypointsVC.persistenceStack = persistenceStack
        waypointsVC.trip = trip
        self.navigationController?.pushViewController(waypointsVC, animated: true)
    }
}
