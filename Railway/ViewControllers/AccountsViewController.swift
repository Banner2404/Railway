//
//  AccountsViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 11/26/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class AccountsViewController: NSViewController, BaseViewController {

    class func loadFromStoryboard() -> Self {
        return loadFromAdminStoryboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

//MARK: - AdminChildViewController
extension AccountsViewController: AdminChildViewController {
    
    func selectedObject() -> Any? {
        return Account()
    }
    
    func reloadData() {
    }
}

