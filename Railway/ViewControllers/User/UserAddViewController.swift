//
//  UserAddTicketViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 12/10/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

protocol UserAddViewControllerDelegate: class {
    func addViewControllerDidCancel(_ addViewController: UserAddViewController)
    func addViewControllerDidComplete(_ addViewController: UserAddViewController)
}

protocol AddTicketChildViewControllerDelegate: class {
    func changeValidation(isValid: Bool)
}

class UserAddViewController: NSViewController, BaseViewController, ContainerViewController {
    
    @IBOutlet weak var containerView: NSView!
    @IBOutlet weak var nextButton: NSButton!
    @IBOutlet weak var previousButton: NSButton!
    @IBOutlet weak var helperMessageLabel: NSTextField!
    weak var delegate: UserAddViewControllerDelegate?
    var tripViewController: TripViewController?
    var trainViewController: SelectTrainViewController?

    var dataManager: DataManager?
    var state = State.tripInfo {
        didSet {
            if oldValue == state { return }
            setup(state)
        }
    }
    
    class func loadFromStoryboard() -> Self {
        return loadFromUserStoryboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContainerView()
        showTripViewController()
        setup(state)
    }
    
    @IBAction func cancenButtonClick(_ sender: Any) {
        delegate?.addViewControllerDidCancel(self)
    }
    
    @IBAction func nextButtonClick(_ sender: Any) {
        switch state {
        case .tripInfo:
            state = .trainSelection
            let (from, to, date) = tripViewController!.getInfo()
            showTrainViewController()
            trainViewController?.loadData(from: from, to: to, date: date)
            break
        case .trainSelection:
            break
        }
    }
    
    @IBAction func previousButtonClick(_ sender: Any) {
        switch state {
        case .tripInfo:
            break
        case .trainSelection:
            move(from: trainViewController!, to: tripViewController!, inContainerView: containerView)
            state = .tripInfo
        }
    }
}

//MARK: - Private
private extension UserAddViewController {
    
    func setup(_ state: State) {
        switch state {
        case .tripInfo:
            nextButton?.title = "Next"
            previousButton?.isEnabled = false
            nextButton?.isEnabled = true
            helperMessageLabel.stringValue = "Select stations and date:"
        case .trainSelection:
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
    
    func showTripViewController() {
        let viewController = TripViewController.loadFromStoryboard()
        viewController.delegate = self
        helperMessageLabel.stringValue = viewController.helperMessage
        tripViewController = viewController
        show(viewController, inContainerView: containerView)
    }
    
    func showTrainViewController() {
        let viewController = SelectTrainViewController.loadFromStoryboard()
        viewController.delegate = self
        helperMessageLabel.stringValue = viewController.helperMessage
        trainViewController = viewController
        show(viewController, inContainerView: containerView)
    }
    
    func setupDataManager() {
        dataManager = DefaultDataManager<Ticket>()
    }
}

//MARK: - AddTicketChildViewControllerDelegate
extension UserAddViewController: AddTicketChildViewControllerDelegate {
    
    func changeValidation(isValid: Bool) {
        nextButton.isEnabled = isValid
    }
}

//MARK: - Nested types
extension UserAddViewController {
    
    enum State {
        case tripInfo
        case trainSelection
    }
}

