//
//  AddWaypointViewController.swift
//  TripPlanner
//
//  Created by Noah Woodward on 4/27/19.
//  Copyright © 2019 Noah Woodward. All rights reserved.
//

import UIKit

class AddWaypointViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        self.view.backgroundColor = UIColor.white
    }
    private func setupNavBar() {
        let saveNavButton = UIBarButtonItem(title: "Save",
                                            style: UIBarButtonItem.Style.done,
                                            target: self,
                                            action: #selector(saveButtonPressed))
        let cancelNavButton = UIBarButtonItem(title: "Cancel",
                                              style: UIBarButtonItem.Style.done,
                                              target: self,
                                              action: #selector(cancelButtonPressed))
        self.navigationItem.setRightBarButton(saveNavButton,
                                              animated: false)
        self.navigationItem.setLeftBarButton(cancelNavButton,
                                             animated: false)
        self.title = "Add Waypoint"
    }
    @objc private func saveButtonPressed() {
        
    }
    @objc private func cancelButtonPressed() {
        dismiss(animated: false, completion: nil)
    }
}
