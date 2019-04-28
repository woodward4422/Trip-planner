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
    var persistenceStack = CoreDataStack()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupNavBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "waypointCell")
        // Do any additional setup after loading the view.
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
        let navVC = UINavigationController()
        navVC.viewControllers = [addWaypointVC]
        present(navVC,animated: false)
    }
}

extension WaypointViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip.waypoint?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "waypointCell")
        let wayPoints = self.trip.waypoints
        guard let wayPointsUnwrapped = wayPoints else {return cell!}
        cell?.textLabel?.text = wayPointsUnwrapped[indexPath.row].waypointName
        return cell!
    }
}
