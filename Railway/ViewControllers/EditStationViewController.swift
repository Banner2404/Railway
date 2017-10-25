//
//  EditStationViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 10/25/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class EditStationViewController: NSViewController, BaseViewController, EditChildViewController {
    
    var helperMessage = "Setup new station:"
    weak var delegate: EditChildViewControllerDelegate?
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
    
    private func validateTextField() {
        delegate?.setNextButton(enabled: nameTextField.stringValue != "", sender: self)
    }
    
    func continueButtonClick(completion: @escaping (Any?) -> Void) {
        completion(nil)
    }
}

//MARK: - NSTextFieldDelegate
extension EditStationViewController: NSTextFieldDelegate {
    
    override func controlTextDidChange(_ obj: Notification) {
        validateTextField()
    }
    
}
