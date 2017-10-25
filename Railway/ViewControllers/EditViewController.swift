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

protocol EditChildViewController: class {
    var helperMessage: String { get }
    var delegate: EditChildViewControllerDelegate? { get set }
    func continueButtonClick(completion: @escaping () -> Void)
}

protocol EditChildViewControllerDelegate: class {
    func setNextButton(enabled: Bool, sender: EditChildViewController)
}

class EditViewController: NSViewController, BaseViewController, ContainerViewController {

    @IBOutlet weak var containerView: NSView!
    var navigationStack: [(NSViewController & EditChildViewController)] = []
    @objc
    dynamic var canGoBack = false
    @objc
    dynamic var canContinue = true
    @objc
    dynamic var helperMessage = ""
    weak var delegate: EditViewControllerDelegate?
    var selectedType = SidebarItem.Section.stations
    
    class func loadFromStoryboard() -> Self {
        return loadFromAdminStoryboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTypesViewController()
        setupContainerView()
    }
    
    @IBAction func cancenButtonClick(_ sender: Any) {
        delegate?.editViewControllerDidCancel(self)
    }
    
    @IBAction func nextButtonClick(_ sender: Any) {
        currentViewController?.continueButtonClick(completion: { [weak self] in
            if self?.currentViewController is AddItemTypeViewController {
                self?.showStationViewController()
            } else {
                self?.delegate?.editViewControllerDidCancel(self!)
            }
        })
    }
    
    @IBAction func previousButtonClick(_ sender: Any) {
        goBack()
    }
}

//MARK: - Navigation
extension EditViewController {
    
    var currentViewController: (NSViewController & EditChildViewController)? {
        return navigationStack.last
    }
    
    func setCanGoBack() {
        canGoBack = navigationStack.count > 1
    }
    
    func push(_ viewController: (NSViewController & EditChildViewController)) {
        navigationStack.append(viewController)
        setCanGoBack()
    }
    
    func pop() -> (NSViewController & EditChildViewController)? {
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
    
    func goTo(_ viewController: (NSViewController & EditChildViewController)) {
        viewController.delegate = self
        if let currentViewController = currentViewController {
            move(from: currentViewController, to: viewController, inContainerView: containerView)
        } else {
            show(viewController, inContainerView: containerView)
        }
        push(viewController)
        helperMessage = viewController.helperMessage
    }
}

//MARK: - Private
private extension EditViewController {
    
    func setupContainerView() {
        containerView.wantsLayer = true
        containerView.layer?.backgroundColor = NSColor.white.cgColor
        containerView.layer?.borderWidth = 1.0
        containerView.layer?.borderColor = NSColor.lightGray.cgColor
    }
    
    func controllerClass(for selectedType: SidebarItem.Section) -> BaseViewController.Type {
        switch selectedType {
        case .stations:
            return EditStationViewController.self
        }
    }
    
    func showTypesViewController() {
        let viewController = AddItemTypeViewController.loadFromStoryboard()
        goTo(viewController)
    }
    
    func showStationViewController() {
        let viewControllerType = controllerClass(for: selectedType)
        let viewController = viewControllerType.loadFromAdminStoryboard() as (NSViewController & EditChildViewController)
        goTo(viewController)
    }
}

//MARK: - EditChildViewControllerDelegate
extension EditViewController: EditChildViewControllerDelegate {

    func setNextButton(enabled: Bool, sender: EditChildViewController) {
        canContinue = enabled
    }
}
