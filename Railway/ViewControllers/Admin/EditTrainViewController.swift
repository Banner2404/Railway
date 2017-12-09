//
//  EditTrainViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 12/10/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class EditTrainViewController: NSViewController, BaseViewController, FillViewController {

    var helperMessage = "Setup new train:"
    var delegate: FillViewControllerDelegate?
    
    func setInitialObject(_ object: Model) {
    }
    
    func getResultObject() -> Model {
        return Train()
    }
}
