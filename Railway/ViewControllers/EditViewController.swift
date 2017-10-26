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
    func continueButtonClick(completion: @escaping (Any?) -> Void)
}

protocol EditChildViewControllerDelegate: class {
    func setNextButton(enabled: Bool, sender: EditChildViewController)
}

class EditViewController: NSViewController, BaseViewController, ContainerViewController {

    enum State {
        case typeSelecting
        case typeSelected(SidebarItem.Section)
        
        var rawValue: Int {
            switch self {
            case .typeSelecting:
                return 0
            case .typeSelected(_):
                return 1
            }
        }
        
        static func == (lhs: State, rhs: State) -> Bool {
            return lhs.rawValue == rhs.rawValue
        }
        
        var selectedType: SidebarItem.Section? {
            switch self {
            case .typeSelected(let type):
                return type
            default:
                return nil
            }
        }
    }
    
    @IBOutlet weak var containerView: NSView!
    @IBOutlet weak var nextButton: NSButton!
    var navigationStack: [(NSViewController & EditChildViewController)] = []
    @objc
    dynamic var canGoBack = false
    @objc
    dynamic var canContinue = true
    @objc
    dynamic var helperMessage = ""
    weak var delegate: EditViewControllerDelegate?
    var state = State.typeSelecting {
        didSet {
            if oldValue == state { return }
            setup(state)
        }
    }
    
    class func loadFromStoryboard() -> Self {
        return loadFromAdminStoryboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showTypesViewController()
        setupContainerView()
        setup(state)
    }
    
    @IBAction func cancenButtonClick(_ sender: Any) {
        delegate?.editViewControllerDidCancel(self)
    }
    
    @IBAction func nextButtonClick(_ sender: Any) {
        currentViewController?.continueButtonClick(completion: { [weak self] object in
            if self?.currentViewController is AddItemTypeViewController {
                self?.state = .typeSelected(object as! SidebarItem.Section)
                self?.showChildViewController()
            } else {
                self?.delegate?.editViewControllerDidCancel(self!)
            }
        })
    }
    
    @IBAction func previousButtonClick(_ sender: Any) {
        goBack()
        if currentViewController is AddItemTypeViewController {
            state = .typeSelecting
        }
    }
}

//MARK: - Navigation
extension EditViewController {
    
    func setup(_ state: State) {
        switch state {
        case .typeSelecting:
            nextButton.title = "Next"
        case .typeSelected(_):
            nextButton.title = "Create"
        }
    }
    
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
    
    func showChildViewController() {
        guard let selectedType = state.selectedType else { return }
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
