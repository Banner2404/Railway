//
//  EditTrainViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 12/10/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class EditTrainViewController: EditTableViewController, FillViewController {

    let CarriageCellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "CarriageTableCellView")

    let popupItems = ["Econom", "Business"]
    var helperMessage = "Setup new train:"
    var delegate: FillViewControllerDelegate?
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var routeTextField: NSTextField!
    
    @objc
    var train: Train!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validate()
        tableView.selectionHighlightStyle = .none
        
        requestManager.load(id: train.id, token: userAccountManager.token!) { (success: Bool, train: Train?, error: Error?) in
            if let train = train {
                self.train = train
                self.setup()
            }
        }
    }
    
    func setup() {
        if train.routeID != 0 {
            routeTextField.stringValue = "\(train.routeID)"
        }
        tableView.reloadData()
    }
    
    func setInitialObject(_ object: Model) {
        train = object as! Train
    }
    
    func getResultObject() -> Model {
        return train
    }
    
    func validate() {
        let hasRoute = train.routeID != 0
        let validNumber = train.carriages.filter { $0.number == 0 }.count == 0
        delegate?.changeValidation(isValid: hasRoute && validNumber)
    }
    
    @IBAction func addButtonClick(_ sender: Any) {
        let carriage = Carriage()
        carriage.type = popupItems.first!.uppercased()
        train.carriages.append(carriage)
        tableView.reloadData()
        validate()
    }
    @IBAction func removeButtonClick(_ sender: Any) {
        train.carriages.removeLast()
        tableView.reloadData()
    }
}

//MARK: - NSTableViewDataSource
extension EditTrainViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return train.carriages.count
    }
}

//MARK: - NSTextFieldDelegate
extension EditTrainViewController: NSTextFieldDelegate {
    
    override func controlTextDidChange(_ obj: Notification) {
        if let routetf = obj.object as? NSTextField, routetf == routeTextField  {
            let id = routetf.integerValue
            train.routeID = id
            validate()
        }
    }
}

//MARK: - CarriageTableCellViewDelegate
extension EditTrainViewController: CarriageTableCellViewDelegate {
    
    func carriageTableCellView(_ cellView: CarriageTableCellView, didChangeCarriageType type: String) {
        let index = tableView.row(for: cellView)
        let item = train.carriages[index]
        item.type = type.uppercased()
    }
    
    func carriageTableCellView(_ cellView: CarriageTableCellView, didChangeNumberOfSeats seats: Int) {
        let index = tableView.row(for: cellView)
        let item = train.carriages[index]
        item.seats = Array<Int>(repeating: 0, count: seats)
    }
    
    func carriageTableCellView(_ cellView: CarriageTableCellView, didChangeNumber number: Int) {
        let index = tableView.row(for: cellView)
        let item = train.carriages[index]
        item.number = number
        validate()
    }
}

//MARK: - NSTableViewDelegate
extension EditTrainViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.makeView(withIdentifier: CarriageCellIdentifier, owner: self) as! CarriageTableCellView
        let item = train.carriages[row]
        cellView.popup.selectItem(at: popupItems.index(of: item.type) ?? 0)
        cellView.seatsTextField.stringValue = "\(item.seats.count)"
        cellView.numberTextField.stringValue = "\(item.number)"
        cellView.delegate = self
        return cellView
    }
}
