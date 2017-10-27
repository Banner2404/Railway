//
//  EditStationViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 10/25/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class EditStationViewController: NSViewController, BaseViewController, AddChildViewController {
    
    var helperMessage = "Setup new station:"
    weak var delegate: AddChildViewControllerDelegate?
    @objc
    dynamic var station: Station!

    @IBOutlet weak var nameTextField: NSTextField!
    
    class func loadFromStoryboard() -> Self {
        return loadFromAdminStoryboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        nameTextField.window?.makeFirstResponder(nameTextField)
        validateTextField()
    }
    
    func setInitialObject(_ object: Model) {
        station = object as! Station
    }
    
    func getResultObject() -> Model {
        return station
    }
}

//MARK: - Private
private extension EditStationViewController {
    
    func validateTextField() {
        delegate?.changeValidation(isValid: !station.name.isEmpty)
    }
}

//MARK: - NSTextFieldDelegate
extension EditStationViewController: NSTextFieldDelegate {
    
    override func controlTextDidChange(_ obj: Notification) {
        validateTextField()
    }
    
}
