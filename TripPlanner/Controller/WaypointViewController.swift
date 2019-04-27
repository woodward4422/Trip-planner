//
//  WaypointViewController.swift
//  TripPlanner
//
//  Created by Noah Woodward on 4/27/19.
//  Copyright © 2019 Noah Woodward. All rights reserved.
//

import UIKit

class WaypointViewController: UITableViewController, UIConfigurable {
    var trip: Trip!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setupNavBar()
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
        
    }
}
