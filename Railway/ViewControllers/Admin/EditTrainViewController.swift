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
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var routeTextField: NSTextField!
    
    @objc
    var train: Train!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.window?.makeFirstResponder(textField)
        validate()
    }
    
    func setInitialObject(_ object: Model) {
        train = object as! Train
    }
    
    func getResultObject() -> Model {
        return train
    }
    
    func validate() {
        let isNumberValid = textField.integerValue != 0
        let hasRoute = train.routeID != 0
        delegate?.changeValidation(isValid: isNumberValid && hasRoute)
    }
    
    @IBAction func addButtonClick(_ sender: Any) {
        train.carriages.append(Carriage())
        tableView.reloadData()
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
        if let numbertf = obj.object as? NSTextField, numbertf == textField {
            let number = numbertf.integerValue
            train.number = number
            validate()
        }
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
}

//MARK: - NSTableViewDelegate
extension EditTrainViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.makeView(withIdentifier: CarriageCellIdentifier, owner: self) as! CarriageTableCellView
        let item = train.carriages[row]
        cellView.popup.selectItem(at: popupItems.index(of: item.type) ?? 0)
        cellView.seatsTextField.stringValue = "\(item.seats.count)"
        cellView.delegate = self
        return cellView
    }
    
    func tableView(_ tableView: NSTableView, selectionIndexesForProposedSelection proposedSelectionIndexes: IndexSet) -> IndexSet {
        return IndexSet()
    }
}
