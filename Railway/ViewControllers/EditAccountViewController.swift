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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func setInitialObject(_ object: Model) {
        
    }
    
    func getResultObject() -> Model {
        return Account()
    }
    
}
