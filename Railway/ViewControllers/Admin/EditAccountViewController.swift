//
//  EditAccountViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 11/26/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class EditAccountViewController: NSViewController, BaseViewController, FillViewController {
    
    var helperMessage = "Setup new account:"
    var delegate: FillViewControllerDelegate?
    let userTypes: [Account.AccountType] = [.user, .admin]
    
    @objc
    dynamic var account: Account!
    
    @IBOutlet weak var usernameTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSTextField!
    @IBOutlet weak var typePopUp: NSPopUpButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.window?.makeFirstResponder(usernameTextField)
        typePopUp.selectItem(at: userTypes.index(of: account.accountType)!)
        validateTextFields()
    }
    
    @IBAction func popUpValueChanged(_ sender: Any) {
        account.accountType = userTypes[typePopUp.indexOfSelectedItem]
    }
    
    func setInitialObject(_ object: Model) {
        account = object as! Account
    }
    
    func getResultObject() -> Model {
        return account
    }
    
    func validateTextFields() {
        let isInvalid = account.username.isEmpty || account.password.isEmpty
        delegate?.changeValidation(isValid: !isInvalid)
    }
    
}

//MARK: - NSTextFieldDelegate
extension EditAccountViewController: NSTextFieldDelegate {
    
    override func controlTextDidChange(_ obj: Notification) {
        validateTextFields()
    }
    
}
