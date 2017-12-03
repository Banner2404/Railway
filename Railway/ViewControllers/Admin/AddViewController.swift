//
//  EditStationViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 10/25/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

protocol AddViewControllerDelegate: class {
    func addViewControllerDidCancel(_ addViewController: AddViewController)
    func addViewControllerDidComplete(_ addViewController: AddViewController)
}

protocol FillViewController: class {

    var helperMessage: String { get }
    var delegate: FillViewControllerDelegate? { get set }
    func setInitialObject(_ object: Model)
    func getResultObject() -> Model
}

protocol FillViewControllerDelegate: class {
    func changeValidation(isValid: Bool)
}

class AddViewController: NSViewController, BaseViewController, ContainerViewController {

    @IBOutlet weak var containerView: NSView!
    @IBOutlet weak var nextButton: NSButton!
    @IBOutlet weak var previousButton: NSButton!
    @IBOutlet weak var helperMessageLabel: NSTextField!
    weak var delegate: AddViewControllerDelegate?
    var sectionsViewController: AddItemTypeViewController!
    var fillViewController: (NSViewController & FillViewController)?
    var dataManager: DataManager?
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
        setupContainerView()
        showTypesViewController()
        setup(state)
    }
    
    @IBAction func cancenButtonClick(_ sender: Any) {
        delegate?.addViewControllerDidCancel(self)
    }
    
    @IBAction func nextButtonClick(_ sender: Any) {
        switch state {
        case .typeSelecting:
            state = .typeSelected(sectionsViewController.selectedType)
            showChildViewController()
            setupDataManager()
        case .typeSelected(_):
            let object = fillViewController!.getResultObject()
            let token = userAccountManager.token ?? ""
            dataManager!.create(object, token: token, completion: { [weak self] (success, createdObject, error) in
                self?.delegate?.addViewControllerDidComplete(self!)
            })
        }
    }
    
    @IBAction func previousButtonClick(_ sender: Any) {
        move(from: fillViewController!, to: sectionsViewController, inContainerView: containerView)
        state = .typeSelecting
    }
}

//MARK: - Private
private extension AddViewController {
    
    func setup(_ state: State) {
        switch state {
        case .typeSelecting:
            nextButton?.title = "Next"
            previousButton?.isEnabled = false
            nextButton?.isEnabled = true
            helperMessageLabel.stringValue = "Select what would you like to add:"
        case .typeSelected(_):
            nextButton?.title = "Create"
            previousButton?.isEnabled = true
        }
    }
    
    func setupContainerView() {
        containerView.wantsLayer = true
        containerView.layer?.backgroundColor = NSColor.white.cgColor
        containerView.layer?.borderWidth = 1.0
        containerView.layer?.borderColor = NSColor.lightGray.cgColor
    }
    
    func showTypesViewController() {
        let viewController = AddItemTypeViewController.loadFromStoryboard()
        sectionsViewController = viewController
        show(viewController, inContainerView: containerView)
    }
    
    func showChildViewController() {
        guard let selectedType = state.selectedType else { return }
        let viewControllerType = ClassMap.editViewController(for: selectedType)
        let viewController = viewControllerType.loadFromAdminStoryboard() as (NSViewController & FillViewController)
        
        let modelType = ClassMap.model(for: selectedType)
        let model = modelType.init()
        viewController.setInitialObject(model)
        helperMessageLabel.stringValue = viewController.helperMessage
        fillViewController = viewController
        viewController.delegate = self
        move(from: sectionsViewController!, to: viewController, inContainerView: containerView)
    }
    
    func setupDataManager() {
        guard let selectedType = state.selectedType else { return }
        let dataManagerType = ClassMap.dataManager(for: selectedType)
        dataManager = dataManagerType.init()
    }
}

//MARK: - EditChildViewControllerDelegate
extension AddViewController: FillViewControllerDelegate {

    func changeValidation(isValid: Bool) {
        nextButton.isEnabled = isValid
    }
}

//MARK: - Nested types
extension AddViewController {
    
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
}
