//
//  AdminMainViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class AdminMainViewController: NSViewController, ContainerViewController {

    @IBOutlet var sideBarArrayController: NSArrayController!
    @IBOutlet weak var containerView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSidebar()
        showStationsViewController()
    }
    
    func addButtonClick() {
        showEditViewController()
    }
}

//MARK: - Private
private extension AdminMainViewController {
    
    func showStationsViewController() {
        let viewController = StationsViewController.loadFromStoryboard()
        show(viewController, inContainerView: containerView)
    }
    
    func setupSidebar() {
        sideBarArrayController.content = SidebarItem.defaultItems
    }
    
    func showEditViewController() {
        let viewController = EditViewController.loadFromStoryboard()
        viewController.delegate = self
        presentViewControllerAsSheet(viewController)
    }
}

//MARK: - EditViewControllerDelegate
extension AdminMainViewController: EditViewControllerDelegate {
    
    func editViewControllerDidCancel(_ editViewController: EditViewController) {
        dismissViewController(editViewController)
    }
    
}
