//
//  EditStationViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 10/25/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class EditStationViewController: NSViewController, BaseViewController, EditChildViewController {
    
    var type = EditViewController.ChildState.create
    var helperMessage = "Setup new station:"
    weak var delegate: EditChildViewControllerDelegate?
    @objc
    dynamic var object: Station!
    @IBOutlet weak var nameTextField: NSTextField!
    
    class func loadFromStoryboard() -> Self {
        return loadFromAdminStoryboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        object = type.object as? Station ?? Station(name: "", id: 0)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        nameTextField.window?.makeFirstResponder(nameTextField)
        validateTextField()
    }
    
    func continueButtonClick(completion: @escaping (Any?) -> Void) {
        switch type {
        case .create:
            createStation(completion: completion)
        case .edit:
            update(object, completion: completion)
        }
    }
}

//MARK: - Private
private extension EditStationViewController {
    
    func validateTextField() {
        delegate?.setNextButton(enabled: nameTextField.stringValue != "", sender: self)
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
