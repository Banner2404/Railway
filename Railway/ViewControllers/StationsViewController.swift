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
    }
    
}

//MARK: - Private
private extension StationsViewController {
    
    func setupStations() {
        let items = [
            Station(name: "Жабинка", id: 502),
            Station(name: "Жабинка", id: 502),
            Station(name: "Жабинка", id: 502),
            Station(name: "Жабинка", id: 502),
            Station(name: "Жабинка", id: 502),
            ]
        stationsArrayController.content = items
    }
}
