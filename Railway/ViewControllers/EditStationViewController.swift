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
    dynamic var object: Station!
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
    
    func continueButtonClick(completion: @escaping (Any?) -> Void) {

    }
}

//MARK: - Private
private extension EditStationViewController {
    
    func validateTextField() {
        delegate?.changeValidation(isValid: !object.name.isEmpty)
    }
    
    func createStation(completion: @escaping (Any?) -> Void) {
        print("Create")
        requestManager.create(object) { (success, station, error) in
            defer {
                completion(nil)
            }
        }
    }
    
    func update(_ station: Station, completion: @escaping (Any?) -> Void) {
        print("Update")
        completion(nil)
    }
}

//MARK: - NSTextFieldDelegate
extension EditStationViewController: NSTextFieldDelegate {
    
    override func controlTextDidChange(_ obj: Notification) {
        validateTextField()
    }
    
}
