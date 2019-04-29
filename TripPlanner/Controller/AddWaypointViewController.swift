//
//  AddWaypointViewController.swift
//  TripPlanner
//
//  Created by Noah Woodward on 4/27/19.
//  Copyright © 2019 Noah Woodward. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
protocol WayPointDelegate: class {
    func wayPointSelected(waypoint: Waypoint)
}

class AddWaypointViewController: UIViewController {
    var waypoint: Waypoint?
    var trip: Trip!
    weak var waypointDelegate: WayPointDelegate!
    weak var topView: UIView!
    weak var waypointLabel: UILabel!
    weak var changeWayPoint: UILabel!
    weak var mapView: GMSMapView!
    weak var cameraPosition: GMSCameraPosition?
    var persistenceStack = CoreDataStack()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        self.view.backgroundColor = UIColor.white
    }
    override func loadView() {
        super.loadView()
        setupTopView()
        setupMapView()
        setupWaypointLabel()
        setupChangeWayPointLabel()
    }
    private func setupTopView() {
        let topView = UIView(frame: .zero)
        topView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(topView)
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: self.view.topAnchor),
            topView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: self.view.frame.height/2)
            ])
        topView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.topView = topView
    }
    private func setupMapView() {
        let mapView = GMSMapView.map(withFrame: .zero,
                                     camera: GMSCameraPosition(latitude: 37.7749, longitude: 122.4194, zoom: 6.0))
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
        self.mapView = mapView
    }
    private func setupChangeWayPointLabel() {
        let changeWayPoint = UILabel(frame: .zero)
        changeWayPoint.translatesAutoresizingMaskIntoConstraints = false
        self.topView.addSubview(changeWayPoint)
        NSLayoutConstraint.activate([
            changeWayPoint.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            changeWayPoint.topAnchor.constraint(equalTo: waypointLabel.bottomAnchor, constant: 30)
            ])
        changeWayPoint.sizeToFit()
        changeWayPoint.text = "Tap to select a waypoint"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeWaypointPressed))
        changeWayPoint.addGestureRecognizer(tapGesture)
        changeWayPoint.isUserInteractionEnabled = true
        self.changeWayPoint = changeWayPoint
    }
    @objc private func changeWaypointPressed() {
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        let filter = GMSAutocompleteFilter()
        autoCompleteController.autocompleteFilter = filter
        self.navigationController?.pushViewController(autoCompleteController, animated: true)
    }
    private func setupWaypointLabel() {
        let waypointLabel = UILabel(frame: .zero)
        waypointLabel.translatesAutoresizingMaskIntoConstraints = false
        self.topView.addSubview(waypointLabel)
        NSLayoutConstraint.activate([
            waypointLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            waypointLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            waypointLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
        waypointLabel.sizeToFit()
        if let destinationWayPoint = waypoint?.waypointName {
            waypointLabel.text = destinationWayPoint
        } else {
            waypointLabel.text = "No Destination Set"
        }
        self.waypointLabel = waypointLabel
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
        if let waypoint = self.waypoint {
            trip.addToWaypoint(waypoint)
            persistenceStack.saveContext()
        }
        self.dismiss(animated: true, completion: nil)
    }
    @objc private func cancelButtonPressed() {
        dismiss(animated: false, completion: nil)
    }
}

extension AddWaypointViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.waypointLabel.text = place.formattedAddress
        let marker = GMSMarker()
        marker.position = place.coordinate
        marker.title = place.formattedAddress
        marker.snippet = "New Waypoint!"
        marker.map = mapView
        mapView.camera = GMSCameraPosition(target: place.coordinate, zoom: 15.0)
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else{ return  }
        let newWaypoint = Waypoint(context: context)
        newWaypoint.latitude = place.coordinate.latitude as Double
        newWaypoint.longitude = place.coordinate.longitude as Double
        newWaypoint.waypointName = place.formattedAddress
        self.waypoint = newWaypoint
        self.navigationController?.popViewController(animated: false)
    }
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error with Autocomplete: \(error.localizedDescription)")
    }
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        self.navigationController?.popViewController(animated: false)
    }
}
