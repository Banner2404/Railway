//
//  EditStationViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 10/25/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

protocol EditViewControllerDelegate: class {
    func editViewControllerDidCancel(_ editViewController: EditViewController)
}

class EditViewController: NSViewController, BaseViewController, ContainerViewController {

    @IBOutlet weak var containerView: NSView!
    @objc
    var canGoBack: Bool {
        return !(childViewControllers.first is EditViewController)
    }
    weak var delegate: EditViewControllerDelegate?
    
    class func loadFromStoryboard() -> Self {
        return loadFromAdminStoryboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTypesViewController()
    }
    
    @IBAction func cancenButtonClick(_ sender: Any) {
        delegate?.editViewControllerDidCancel(self)
    }
}

//MARK: - Private
private extension EditViewController {
    
    func showTypesViewController() {
        let viewController = AddItemTypeViewController.loadFromStoryboard()
        show(viewController, inContainerView: containerView)
    }
}
