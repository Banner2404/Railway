//
//  EditLogViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 12/9/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class EditLogViewController: NSViewController, BaseViewController, FillViewController {
    
    var helperMessage = "Setup new route:"
    var delegate: FillViewControllerDelegate?
    
    func setInitialObject(_ object: Model) {
    }
    
    func getResultObject() -> Model {
        return LogRecord()
    }
}
