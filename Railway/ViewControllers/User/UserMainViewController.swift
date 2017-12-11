//
//  UserMainViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 12/10/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class UserMainViewController: NSViewController, BaseViewController, ContainerViewController {

    @IBOutlet weak var containerView: NSView!
    var ticketsViewController: UserTicketsViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func addButtonClick() {
        showAddViewController()
    }
    
    func deleteButtonClick() {
        let object = (ticketsViewController?.selectedObject() as! NSCopying).copy() as! Model
        
        let dataManager = DefaultDataManager<Ticket>()
        let token = userAccountManager.token ?? ""
        dataManager.delete(object, token: token) { (success, error) in
            self.ticketsViewController?.reloadData()
        }
    }
    
    override func validateToolbarItem(_ item: NSToolbarItem) -> Bool {
        if item.itemIdentifier == ToolbarIdentifier.Add {
            return true
        }
        return ticketsViewController.validateToolbarItem(item)
    }
    
    func setup() {
        ticketsViewController = UserTicketsViewController.loadFromUserStoryboard()
        show(ticketsViewController, inContainerView: containerView)
    }
    
    func showAddViewController() {
        let viewController = UserAddViewController.loadFromStoryboard()
        viewController.delegate = self
        presentViewControllerAsSheet(viewController)
    }
}

//MARK: - UserAddViewControllerDelegate
extension UserMainViewController: UserAddViewControllerDelegate {
    
    func addViewControllerDidCancel(_ addViewController: UserAddViewController) {
        dismissViewController(addViewController)
    }
    func addViewControllerDidComplete(_ addViewController: UserAddViewController) {
        dismissViewController(addViewController)
        ticketsViewController.reloadData()
    }
}
