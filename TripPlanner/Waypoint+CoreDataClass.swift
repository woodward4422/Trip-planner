//
//  Waypoint+CoreDataClass.swift
//  TripPlanner
//
//  Created by Noah Woodward on 4/27/19.
//  Copyright © 2019 Noah Woodward. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Waypoint)
public class Waypoint: NSManagedObject {
    convenience init?(latitude: Double, longitude: Double, waypointName: String?, trip: Trip? ) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else{ return nil }
        self.init(entity: Waypoint.entity(), insertInto: context)
        self.latitude = latitude
        self.longitude = longitude
        self.waypointName = waypointName
        self.trip = trip
    }
}
