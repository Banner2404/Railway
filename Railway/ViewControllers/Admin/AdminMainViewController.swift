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
        let object = (currentChildViewController?.selectedObject() as! NSCopying).copy() as! Model
        showEditViewController(with: section, object: object)
    }
    
    func deleteButtonClick() {
        let section = selectedSidebarItem().section
        let object = (currentChildViewController?.selectedObject() as! NSCopying).copy() as! Model

        let dataManagerClass = ClassMap.dataManager(for: section)
        let dataManager = dataManagerClass.init()
        dataManager.delete(object) { (success, error) in
            self.currentChildViewController?.reloadData()
        }
    }
    
    @IBAction func sectionsTableViewSelectionChanged(_ sender: NSTableView) {
        let selectedItemIndex = sender.selectedRow;
        let selectedType = (sideBarArrayController.content as! [SidebarItem])[selectedItemIndex]
        showChildViewController(for: selectedType.section)
    }
}

//MARK: - Private
private extension AdminMainViewController {
    
    func controllerClass(for selectedType: SidebarItem.Section) -> (BaseViewController & AdminChildViewController).Type {
        switch selectedType {
        case .stations:
            return StationsViewController.self
        case .accounts:
            return AccountsViewController.self
        case .passengers:
            return PassengersViewController.self
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
        let viewController = AddViewController.loadFromStoryboard()
        viewController.delegate = self
        presentViewControllerAsSheet(viewController)
    }
    
    func showEditViewController(with section: SidebarItem.Section, object: Model) {
        let viewController = EditViewController.loadFromStoryboard()
        viewController.selectedType = section
        viewController.delegate = self
        viewController.initialObject = object
        presentViewControllerAsSheet(viewController)
    }
    
    func selectedSidebarItem() -> SidebarItem {
        return sideBarArrayController.selectedObjects.first as! SidebarItem
    }
}

//MARK: - AddViewControllerDelegate
extension AdminMainViewController: AddViewControllerDelegate {
    
    func addViewControllerDidCancel(_ addViewController: AddViewController) {
        dismissViewController(addViewController)
    }
    
    func addViewControllerDidComplete(_ addViewController: AddViewController) {
        dismissViewController(addViewController)
        currentChildViewController?.reloadData()
    }
    
}

//MARK: - EditViewControllerDelegate
extension AdminMainViewController: EditViewControllerDelegate {
    
    func editViewControllerDidCancel(_ editViewController: EditViewController) {
        dismissViewController(editViewController)
    }
    
    func editViewControllerDidComplete(_ editViewController: EditViewController) {
        dismissViewController(editViewController)
        currentChildViewController?.reloadData()
    }
    
}