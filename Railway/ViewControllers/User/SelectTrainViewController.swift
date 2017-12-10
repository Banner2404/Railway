//
//  SelectTrainViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 12/10/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class SelectTrainViewController: NSViewController, BaseViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet var arrayController: NSArrayController!
    
    var helperMessage = "Select train:"
    weak var delegate: AddTicketChildViewControllerDelegate?
    
    class func loadFromStoryboard() -> Self {
        return loadFromStoryboard(name: "User")
    }
    
    func loadData(from: Station, to: Station, date: Date) {
        let token = userAccountManager.token!
        requestManager.trains(from: from, to: to, date: date, token: token) { (success, trains, error) in
            self.arrayController.content = trains?.data
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validate()
    }
    
    func validate() {
        delegate?.changeValidation(isValid: !arrayController.selectionIndexes.isEmpty)
    }
    
    @IBAction func selectionChanged(_ sender: Any) {
        validate()
    }
    
}
