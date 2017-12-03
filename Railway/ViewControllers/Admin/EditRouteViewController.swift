//
//  EditRouteViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 12/3/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class EditRouteViewController: NSViewController, BaseViewController, FillViewController {

    var helperMessage = "Setup new route:"
    var delegate: FillViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //nameTextField.window?.makeFirstResponder(nameTextField)
        validateTextFields()
    }
    
    func setInitialObject(_ object: Model) {
        //
    }
    
    func getResultObject() -> Model {
        return Route()
    }
    
    func validateTextFields() {
//        let isInvalid = passenger.name.isEmpty || passenger.passport.isEmpty
//        delegate?.changeValidation(isValid: !isInvalid)
    }
    
}
