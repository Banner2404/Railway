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
    var navigationStack: [NSViewController] = []
    @objc
    dynamic var canGoBack = false
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
    
    @IBAction func nextButtonClick(_ sender: Any) {
        showStationViewController()
    }
    
    @IBAction func previousButtonClick(_ sender: Any) {
        goBack()
    }
}

//MARK: - Navigation
extension EditViewController {
    
    var currentViewController: NSViewController? {
        return navigationStack.last
    }
    
    func setCanGoBack() {
        canGoBack = navigationStack.count > 1
    }
    
    func push(_ viewController: NSViewController) {
        navigationStack.append(viewController)
        setCanGoBack()
    }
    
    func pop() -> NSViewController? {
        let vc = navigationStack.popLast()
        setCanGoBack()
        return vc
    }
    
    func goBack() {
        if !canGoBack { return }
        let oldViewController = pop()!
        let newViewController = currentViewController!
        move(from: oldViewController, to: newViewController, inContainerView: containerView)
    }
}

//MARK: - Private
private extension EditViewController {
    
    func showTypesViewController() {
        let viewController = AddItemTypeViewController.loadFromStoryboard()
        show(viewController, inContainerView: containerView)
        push(viewController)
    }
    
    func showStationViewController() {
        let viewController = EditStationViewController.loadFromStoryboard()
        move(from: childViewControllers.first!, to: viewController, inContainerView: containerView)
        push(viewController)
    }
}
