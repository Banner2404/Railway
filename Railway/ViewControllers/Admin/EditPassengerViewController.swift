//
//  EditPassengerViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 11/27/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class EditPassengerViewController: NSViewController, BaseViewController, FillViewController {
    
    var helperMessage = "Setup new passenger:"
    var delegate: FillViewControllerDelegate?
    
    @objc
    dynamic var passenger: Passenger!
    
    @IBOutlet weak var nameTextField: NSTextField!
    @IBOutlet weak var passportTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.window?.makeFirstResponder(nameTextField)
        validateTextFields()
    }
    
    func setInitialObject(_ object: Model) {
        passenger = object as! Passenger
    }
    
    func getResultObject() -> Model {
        return passenger
    }
    
    func validateTextFields() {
        let isInvalid = passenger.name.isEmpty || passenger.passport.isEmpty
        delegate?.changeValidation(isValid: !isInvalid)
    }
}

//MARK: - NSTextFieldDelegate
extension EditPassengerViewController: NSTextFieldDelegate {
    
    override func controlTextDidChange(_ obj: Notification) {
        validateTextFields()
    }
    
}
