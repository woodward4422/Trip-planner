//
//  Waypoint+CoreDataProperties.swift
//  TripPlanner
//
//  Created by Noah Woodward on 4/27/19.
//  Copyright © 2019 Noah Woodward. All rights reserved.
//
//

import Foundation
import CoreData

extension Waypoint {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Waypoint> {
        return NSFetchRequest<Waypoint>(entityName: "Waypoint")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var waypointName: String?
    @NSManaged public var trip: Trip?

}
