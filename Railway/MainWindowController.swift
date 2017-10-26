//
//  MainWindowController.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    var viewController: AdminMainViewController {
        return contentViewController as! AdminMainViewController
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }

    @IBAction func addButtonClick(_ sender: Any) {
        viewController.addButtonClick()
    }
    
    @IBAction func editButtonClick(_ sender: Any) {
        viewController.editButtonClick()
    }
    
    override func validateToolbarItem(_ item: NSToolbarItem) -> Bool {
        return viewController.validateToolbarItem(item)
    }
}
