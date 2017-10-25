//
//  EditStationViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 10/25/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class EditViewController: NSViewController, BaseViewController, ContainerViewController {

    @IBOutlet weak var containerView: NSView!
    
    class func loadFromStoryboard() -> Self {
        return loadFromAdminStoryboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTypesViewController()
    }
    
}

//MARK: - Private
private extension EditViewController {
    
    func showTypesViewController() {
        let viewController = AddItemTypeViewController.loadFromStoryboard()
        show(viewController, inContainerView: containerView)
    }
}
