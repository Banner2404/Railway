//
//  UserWindowController.swift
//  Railway
//
//  Created by Соболь Евгений on 12/10/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class UserWindowController: NSWindowController {

    class func loadFromStoryboard() -> MainWindowController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "User"), bundle: nil)
        let window = storyboard.instantiateInitialController() as! MainWindowController
        return window
    }
    
    var viewController: UserMainViewController {
        return contentViewController as! UserMainViewController
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    @IBAction func addButtonClick(_ sender: Any) {
        viewController.addButtonClick()
    }
    
    @IBAction func deleteButtonClick(_ sender: Any) {
        viewController.deleteButtonClick()
    }
    
    override func validateToolbarItem(_ item: NSToolbarItem) -> Bool {
        return viewController.validateToolbarItem(item)
    }

}
