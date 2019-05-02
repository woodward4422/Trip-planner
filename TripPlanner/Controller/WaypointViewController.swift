//
//  WaypointViewController.swift
//  TripPlanner
//
//  Created by Noah Woodward on 4/27/19.
//  Copyright © 2019 Noah Woodward. All rights reserved.
//

import UIKit
import CoreData
class WaypointViewController: UITableViewController, UIConfigurable {
    var trip: Trip!
    var persistenceStack: CoreDataStack!
    lazy var fetchedResultsController: NSFetchedResultsController<Waypoint> = {
        let fetchRequest: NSFetchRequest<Waypoint> = Waypoint.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "trip = %@", trip)
        let sortDescriptor = NSSortDescriptor(key: "waypointName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                  managedObjectContext: persistenceStack.managedContext,
                                                                  sectionNameKeyPath: nil,
                                                                  cacheName: nil)
        return fetchedResultsController
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupNavBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "waypointCell")
        loadData()
        // Do any additional setup after loading the view.
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
    func setupNavBar() {
        let rightNavBarItem = UIBarButtonItem(title: "Add",
                                              style: UIBarButtonItem.Style.plain,
                                              target: self,
                                              action: #selector(addButtonPressed))
        self.navigationItem.setRightBarButton(rightNavBarItem, animated: false)
        self.title = trip.tripName
    }
    @objc private func addButtonPressed() {
        let addWaypointVC = AddWaypointViewController()
        addWaypointVC.trip = self.trip
        addWaypointVC.persistenceStack = persistenceStack
        let navVC = UINavigationController()
        navVC.viewControllers = [addWaypointVC]
        present(navVC, animated: false)
    }
}
extension WaypointViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionInfo =
            fetchedResultsController.sections?[section] else {
                return 0
        }
        return sectionInfo.numberOfObjects
    }
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            persistenceStack.deleteWaypoint(waypoint: fetchedResultsController.object(at: indexPath))
            loadData()
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "waypointCell")
        let cellWaypoint = fetchedResultsController.object(at: indexPath)
        cell?.textLabel?.text = cellWaypoint.waypointName
        return cell!
    }
}
