//
//  AdminMainViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

protocol AdminChildViewController: class {
    func selectedObject() -> Any?
    func reloadData()
}

class AdminMainViewController: NSViewController, ContainerViewController {

    @IBOutlet var sideBarArrayController: NSArrayController!
    @IBOutlet weak var sideBarTableView: NSTableView!
    @IBOutlet weak var containerView: NSView!
    var currentChildViewController: (NSViewController & AdminChildViewController)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSidebar()
        sectionsTableViewSelectionChanged(sideBarTableView)
    }
    
    override func validateToolbarItem(_ item: NSToolbarItem) -> Bool {
        if item.itemIdentifier == ToolbarIdentifier.Add {
            return true
        }
        return currentChildViewController?.validateToolbarItem(item) ?? false
    }
    
    func addButtonClick() {
        showAddViewController()
    }
    
    func editButtonClick() {
        let section = selectedSidebarItem().section
        let object = (currentChildViewController?.selectedObject() as! NSCopying).copy()
        showEditViewController(with: section, object: object)
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
        let viewController = viewControllerClass.loadFromAdminStoryboard() as (NSViewController & AdminChildViewController)
        show(viewController, inContainerView: containerView)
        currentChildViewController = viewController
    }
    
    func setupSidebar() {
        sideBarArrayController.content = SidebarItem.defaultItems
    }
    
    func showAddViewController() {
        let viewController = EditViewController.loadFromStoryboard()
        viewController.delegate = self
        viewController.state = .typeSelecting
        presentViewControllerAsSheet(viewController)
    }
    
    func showEditViewController(with section: SidebarItem.Section, object: Any?) {
        let viewController = EditViewController.loadFromStoryboard()
        viewController.state = .edit(section, object)
        viewController.delegate = self
        presentViewControllerAsSheet(viewController)
    }
    
    func selectedSidebarItem() -> SidebarItem {
        return sideBarArrayController.selectedObjects.first as! SidebarItem
    }
}

//MARK: - EditViewControllerDelegate
extension AdminMainViewController: EditViewControllerDelegate {
    
    func editViewControllerDidCancel(_ editViewController: EditViewController) {
        dismissViewController(editViewController)
        currentChildViewController?.reloadData()
    }
    
}
