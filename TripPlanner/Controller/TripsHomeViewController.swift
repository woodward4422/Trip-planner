//
//  ViewController.swift
//  TripPlanner
//
//  Created by Noah Woodward on 4/26/19.
//  Copyright © 2019 Noah Woodward. All rights reserved.
//

import UIKit

class TripsHomeViewController: UITableViewController {
    // MARK: METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    private func setupNavBar() {
        let addNavButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.add,
            target: self,
            action: #selector(addTripButtonPressed))
        self.navigationItem.setRightBarButton(addNavButton, animated: false)
        self.title = "Planned Trips"
    }
    @objc private func addTripButtonPressed() {
        let addTripVC = AddTripViewController()
        let navigationVC = UINavigationController()
        navigationVC.viewControllers = [addTripVC]
        self.present(navigationVC, animated: false, completion: nil)
    }
}
