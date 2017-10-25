//
//  AdminMainViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

protocol AdminChildViewController {
    func addButtonClick()
}

class AdminMainViewController: NSViewController {

    @IBOutlet var sideBarArrayController: NSArrayController!
    @IBOutlet weak var containerView: NSView!
    var contentController: AdminChildViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSidebar()
        showStationsViewController()
    }
    
    func addButtonClick() {
        contentController?.addButtonClick()
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
        contentController = viewController
    }
    
    func setupSidebar() {
        sideBarArrayController.content = SidebarItem.defaultItems
    }
}
