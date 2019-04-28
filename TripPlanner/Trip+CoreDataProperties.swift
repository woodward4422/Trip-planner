//
//  Trip+CoreDataProperties.swift
//  TripPlanner
//
//  Created by Noah Woodward on 4/27/19.
//  Copyright © 2019 Noah Woodward. All rights reserved.
//
//

import Foundation
import CoreData

extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip")
    }

    @NSManaged public var tripName: String?
    @NSManaged public var waypoint: NSOrderedSet?

}

// MARK: Generated accessors for waypoint
extension Trip {

    @objc(insertObject:inWaypointAtIndex:)
    @NSManaged public func insertIntoWaypoint(_ value: Waypoint, at idx: Int)

    @objc(removeObjectFromWaypointAtIndex:)
    @NSManaged public func removeFromWaypoint(at idx: Int)

    @objc(insertWaypoint:atIndexes:)
    @NSManaged public func insertIntoWaypoint(_ values: [Waypoint], at indexes: NSIndexSet)

    @objc(removeWaypointAtIndexes:)
    @NSManaged public func removeFromWaypoint(at indexes: NSIndexSet)

    @objc(replaceObjectInWaypointAtIndex:withObject:)
    @NSManaged public func replaceWaypoint(at idx: Int, with value: Waypoint)

    @objc(replaceWaypointAtIndexes:withWaypoint:)
    @NSManaged public func replaceWaypoint(at indexes: NSIndexSet, with values: [Waypoint])

    @objc(addWaypointObject:)
    @NSManaged public func addToWaypoint(_ value: Waypoint)

    @objc(removeWaypointObject:)
    @NSManaged public func removeFromWaypoint(_ value: Waypoint)

    @objc(addWaypoint:)
    @NSManaged public func addToWaypoint(_ values: NSOrderedSet)

    @objc(removeWaypoint:)
    @NSManaged public func removeFromWaypoint(_ values: NSOrderedSet)

}
