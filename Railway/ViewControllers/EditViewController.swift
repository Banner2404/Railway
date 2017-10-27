//
//  EditViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 10/27/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

protocol EditViewControllerDelegate: class {
    func editViewControllerDidCancel(_ editViewController: EditViewController)
    func editViewControllerDidComplete(_ editViewController: EditViewController)
}


class EditViewController: NSViewController, BaseViewController, ContainerViewController {

    @IBOutlet weak var containerView: NSView!
    @IBOutlet weak var helperMessageLabel: NSTextField!
    var initialObject: Model!
    var selectedType: SidebarItem.Section!
    var dataManager: DataManager!
    var fillViewController: (NSViewController & FillViewController)!
    weak var delegate: EditViewControllerDelegate?
    
    class func loadFromStoryboard() -> Self {
        return loadFromAdminStoryboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFillViewController()
        setupDataManager()
    }
    
    @IBAction func saveButtonClick(_ sender: Any) {
        let object = fillViewController.getResultObject()
        dataManager.update(object) { [weak self] (_, _, _) in
            self?.delegate?.editViewControllerDidComplete(self!)
        }
    }
    
    @IBAction func cancelButtonClick(_ sender: Any) {
        delegate?.editViewControllerDidCancel(self)
    }
}

//MARK: - Private
private extension EditViewController {
    
    func setupFillViewController() {
        let viewControllerClass = ClassMap.editViewController(for: selectedType)
        fillViewController = viewControllerClass.loadFromAdminStoryboard() as (NSViewController & FillViewController)
        fillViewController.setInitialObject(initialObject)
        helperMessageLabel.stringValue = fillViewController.helperMessage
        show(fillViewController, inContainerView: containerView)
    }
    
    func setupDataManager() {
        let dataManagerClass = ClassMap.dataManager(for: selectedType)
        dataManager = dataManagerClass.init()
    }
}
