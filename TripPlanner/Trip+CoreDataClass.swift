//
//  Trip+CoreDataClass.swift
//  TripPlanner
//
//  Created by Noah Woodward on 4/27/19.
//  Copyright © 2019 Noah Woodward. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Trip)
public class Trip: NSManagedObject {
    var waypoints: [Waypoint]? {
        return self.waypoint?.array as? [Waypoint]
    }
}
