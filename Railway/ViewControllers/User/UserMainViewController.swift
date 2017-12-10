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
    }
    
    func deleteButtonClick() {
    
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
}
