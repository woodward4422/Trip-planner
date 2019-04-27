//
//  UserPreferences.swift
//  TripPlanner
//
//  Created by Noah Woodward on 4/26/19.
//  Copyright © 2019 Noah Woodward. All rights reserved.
//

import Foundation

struct UserPreferences {
    static func saveUserName(name: String) {
        UserDefaults.standard.setValue(name, forKey: UserKeys.userName)
    }
    static func saveUserDistanceMetrics(metrics: Metrics) {
        UserDefaults.standard.setValue(metrics.rawValue, forKey: UserKeys.distanceMetrics)
    }
    static func saveUserCurrencyPreferrences(distanceMetrics: Currency) {
        UserDefaults.standard.setValue(distanceMetrics.rawValue, forKey: UserKeys.distanceMetrics)
    }
    static func saveIsDarkModePrefferences(isDark: Bool) {
        UserDefaults.standard.setValue(isDark, forKey: UserKeys.isDarkMode)
    }
}
