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
    @IBOutlet weak var sideBarTableView: NSTableView!
    @IBOutlet weak var containerView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSidebar()
        sectionsTableViewSelectionChanged(sideBarTableView)
    }
    
    func addButtonClick() {
        showEditViewController()
    }
    
    @IBAction func sectionsTableViewSelectionChanged(_ sender: NSTableView) {
        let selectedItemIndex = sender.selectedRow;
        let selectedType = (sideBarArrayController.content as! [SidebarItem])[selectedItemIndex]
        showChildViewController(for: selectedType.section)
    }
}

//MARK: - Private
private extension AdminMainViewController {
    
    func controllerClass(for selectedType: SidebarItem.Section) -> BaseViewController.Type {
        switch selectedType {
        case .stations:
            return StationsViewController.self
        }
    }
    
    func showChildViewController(for selectedType: SidebarItem.Section) {
        let viewControllerClass = controllerClass(for: selectedType)
        let viewController = viewControllerClass.loadFromAdminStoryboard() as NSViewController
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
