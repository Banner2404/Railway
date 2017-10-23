//
//  StationsViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class StationsViewController: NSViewController, BaseViewController {

    @IBOutlet var stationsArrayController: NSArrayController!
    
    class func loadFromStoryboard() -> Self {
        return loadFromAdminStoryboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStations()
        loadStations()
    }
    
    @objc
    func sortDescriptors() -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "id", ascending: true),
        ]
    }
    
}

//MARK: - Private
private extension StationsViewController {
    
    func loadStations() {
        requestManager.loadStations { [weak self] (success, stations, error) in
            if success {
                self?.stationsArrayController.content = stations?.stations
            } else {
                print(error ?? "Unable to load stations")
            }
        }
    }
    
    func setupStations() {
        let items = [
            Station(name: "Жабинкаa", id: 501),
            Station(name: "Жабинкаb", id: 502),
            Station(name: "Жабинкаz", id: 503),
            Station(name: "Жабинкаc", id: 504),
            Station(name: "Жабинкаg", id: 505),
            ]
        stationsArrayController.content = items
    }
}

//MARK: - AdminChildViewController
extension StationsViewController: AdminChildViewController {
    func addButtonClick() {
        print("Click handled")
    }
    
}
