//
//  SettingsViewController.swift
//  TripPlanner
//
//  Created by Noah Woodward on 5/1/19.
//  Copyright © 2019 Noah Woodward. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    weak var metricsSegmentedControl: UISegmentedControl!
    weak var currencySegmentedControl: UISegmentedControl!
    weak var darkModeSegmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    override func loadView() {
        super.loadView()
        self.title = "Settings"
        setupMetrics()
        setupCurrency()
        setupDarkMode()
    }
    private func setupMetrics() {
        let metricsSegmentedControl = UISegmentedControl(items: ["Kilomters", "Miles"])
        metricsSegmentedControl.frame = .zero
        metricsSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(metricsSegmentedControl)
        metricsSegmentedControl.selectedSegmentIndex = 0
        metricsSegmentedControl.addTarget(self, action: #selector(metricsChanged), for: .valueChanged)
        NSLayoutConstraint.activate([
            metricsSegmentedControl.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100),
            metricsSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            metricsSegmentedControl.heightAnchor.constraint(equalToConstant: 45),
            metricsSegmentedControl.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.75)
            ])
        self.metricsSegmentedControl = metricsSegmentedControl
    }
    @objc private func metricsChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UserPreferences.saveUserDistanceMetrics(metrics: .kilometer)
        case 1:
            UserPreferences.saveUserDistanceMetrics(metrics: .mile)
        default:
            break
        }
    }
    private func setupCurrency() {
        let currencySegmentedControl = UISegmentedControl(items: ["USD","Euro","Peso"])
        currencySegmentedControl.frame = .zero
        currencySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(currencySegmentedControl)
        currencySegmentedControl.selectedSegmentIndex = 0
        currencySegmentedControl.addTarget(self, action: #selector(currencyChanged), for: .valueChanged)
        NSLayoutConstraint.activate([
            currencySegmentedControl.topAnchor.constraint(equalTo: self.metricsSegmentedControl.bottomAnchor, constant: 40),
            currencySegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            currencySegmentedControl.heightAnchor.constraint(equalToConstant: 45),
            currencySegmentedControl.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.75)
            ])
        self.currencySegmentedControl = currencySegmentedControl
    }
    @objc private func currencyChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UserPreferences.saveUserCurrencyPreferrences(distanceMetrics: .dollar)
        case 1:
            UserPreferences.saveUserCurrencyPreferrences(distanceMetrics: .euro)
        case 2:
            UserPreferences.saveUserCurrencyPreferrences(distanceMetrics: .peso)
        default:
            break
        }
    }
    private func setupDarkMode() {
        let darkModeSegmentedControl = UISegmentedControl(items: ["Darkmode On", "Darkmode Off"])
        darkModeSegmentedControl.frame = .zero
        darkModeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        darkModeSegmentedControl.selectedSegmentIndex = 0
        self.view.addSubview(darkModeSegmentedControl)
        darkModeSegmentedControl.addTarget(self, action: #selector(darkModeChanged), for: .valueChanged)
        NSLayoutConstraint.activate([
            darkModeSegmentedControl.topAnchor.constraint(equalTo: self.currencySegmentedControl.bottomAnchor, constant: 40),
            darkModeSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            darkModeSegmentedControl.heightAnchor.constraint(equalToConstant: 45),
            darkModeSegmentedControl.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.75)
            ])
        self.darkModeSegmentedControl = darkModeSegmentedControl
    }
    @objc private func darkModeChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UserPreferences.saveIsDarkModePrefferences(isDark: true)
        case 1:
            UserPreferences.saveIsDarkModePrefferences(isDark: false)
        default:
            break
        }
    }
}
