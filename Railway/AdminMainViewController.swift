//
//  AdminMainViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class AdminMainViewController: NSViewController {

    @IBOutlet var sideBarArrayController: NSArrayController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSidebar()
    }
}

//MARK: - Private
private extension AdminMainViewController {
    
    func setupSidebar() {
        let items = [
            SidebarItem(title: "Tickets", image: #imageLiteral(resourceName: "testIcon")),
            SidebarItem(title: "Stations", image: #imageLiteral(resourceName: "testIcon")),
            SidebarItem(title: "Trains", image: #imageLiteral(resourceName: "testIcon")),
            SidebarItem(title: "Passengers", image: #imageLiteral(resourceName: "testIcon")),
            SidebarItem(title: "Users", image: #imageLiteral(resourceName: "testIcon")),
            SidebarItem(title: "Logs", image: #imageLiteral(resourceName: "testIcon")),
            SidebarItem(title: "Routes", image: #imageLiteral(resourceName: "testIcon")),
        ]
        sideBarArrayController.content = items
    }
}
