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
    @IBOutlet weak var containerView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSidebar()
        showStationsViewController()
    }
}

//MARK: - Private
private extension AdminMainViewController {
    
    func showStationsViewController() {
        let viewController = StationsViewController.loadFromStoryboard()
        addChildViewController(viewController)
        containerView.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
            containerView.leftAnchor.constraint(equalTo: viewController.view.leftAnchor),
            containerView.rightAnchor.constraint(equalTo: viewController.view.rightAnchor),
        ])

    }
    
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
