//
//  AddTripViewController.swift
//  TripPlanner
//
//  Created by Noah Woodward on 4/26/19.
//  Copyright © 2019 Noah Woodward. All rights reserved.
//

import UIKit

class AddTripViewController: UIViewController {
    weak var tripNameStaticLabel: UILabel!
    weak var tripField: UITextField!
    override func loadView() {
        super.loadView()
        setupStaticLabel()
        setupTextField()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        setupNavBar()
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
        self.title = "Add Trip"
    }
    private func setupTextField() {
        let tripField = UITextField(frame: .zero)
        tripField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tripField)
        NSLayoutConstraint.activate([
            tripField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            tripField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 30),
            tripField.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.75),
            tripField.heightAnchor.constraint(equalToConstant: 20)
            ])
        tripField.placeholder = "Enter a trip name"
        tripField.borderStyle = .line
        self.tripField = tripField
    }
    private func setupStaticLabel() {
        let tripNameStaticLabel = UILabel(frame: .zero)
        tripNameStaticLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tripNameStaticLabel)
        NSLayoutConstraint.activate([
            tripNameStaticLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            tripNameStaticLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        tripNameStaticLabel.sizeToFit()
        tripNameStaticLabel.text = "Give the Trip a Name"
        self.tripNameStaticLabel = tripNameStaticLabel
    }
    @objc private func cancelButtonPressed() {
        tripField.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    @objc private func saveButtonPressed() {
        tripField.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
}
