//
//  User.swift
//  TripPlanner
//
//  Created by Noah Woodward on 4/26/19.
//  Copyright © 2019 Noah Woodward. All rights reserved.
//

import Foundation
class User: NSObject, NSSecureCoding {
    static var supportsSecureCoding = true
    var name: String
    var distanceMetrics: Metrics
    var currencyMetrics: Currency
    var isDarkMode: Bool
    init(name: String,
         distanceMetrics: Metrics,
         currencyMetrics: Currency,
         isDarkMode: Bool) {
        self.name = name
        self.distanceMetrics = distanceMetrics
        self.currencyMetrics = currencyMetrics
        self.isDarkMode = isDarkMode
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: UserKeys.userName)
        aCoder.encode(self.distanceMetrics, forKey: UserKeys.distanceMetrics)
        aCoder.encode(self.currencyMetrics, forKey: UserKeys.currencyMetrics)
        aCoder.encode(self.isDarkMode, forKey: UserKeys.isDarkMode)
    }
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: UserKeys.userName) as? String,
              let distanceMetrics = aDecoder.decodeObject(forKey: UserKeys.distanceMetrics) as? Metrics,
              let currencyMetrics = aDecoder.decodeObject(forKey: UserKeys.currencyMetrics) as? Currency,
              let isDarkMode = aDecoder.decodeObject(forKey: UserKeys.isDarkMode) as? Bool else { return nil}
        self.init(name: name,
                  distanceMetrics: distanceMetrics,
                  currencyMetrics: currencyMetrics,
                  isDarkMode: isDarkMode)
    }
    func archiveUser() -> Data {
        let archivedObject = NSKeyedArchiver.archivedData(withRootObject: self)
        return archivedObject
    }
}

enum Metrics: String {
    case mile
    case kilometer
}

enum Currency: String {
    case dollar
    case euro
    case peso
}
