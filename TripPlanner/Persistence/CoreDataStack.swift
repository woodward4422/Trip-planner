//
//  CoreDataStack.swift
//  TripPlanner
//
//  Created by Noah Woodward on 4/26/19.
//  Copyright © 2019 Noah Woodward. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct CoreDataStack {
    let persistentContainer: NSPersistentContainer = {
        // creates the NSPersistentContainer object
        // must be given the name of the Core Data model file “LoanedItems”
        let container = NSPersistentContainer(name: "Model")
        // swiftlint:disable line_length
        // load the saved database if it exists, creates it if it does not, and returns an error under failure conditions
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error setting up Core Data (\(error)).")
            }
        }
        return container
    }()
    lazy var managedContext: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDelegate?.persistentContainer.viewContext else{ fatalError("The Context is Nil!") }
        return context
    }()
    mutating func saveContext() {
        let viewContext = managedContext
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unsolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    mutating func deleteTrip(trip: Trip) {
        managedContext.delete(trip)
        saveContext()
    }
    mutating func deleteWaypoint(waypoint: Waypoint) {
        managedContext.delete(waypoint)
        saveContext()
    }
}
