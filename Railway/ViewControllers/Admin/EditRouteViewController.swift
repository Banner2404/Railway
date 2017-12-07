//
//  EditRouteViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 12/3/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class EditRouteViewController: NSViewController, BaseViewController, FillViewController {

    let StationCellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "StationTableCellView")
    var helperMessage = "Setup new route:"
    var delegate: FillViewControllerDelegate?
    @IBOutlet weak var numberTextField: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var removeButton: NSButton!
    
    @objc
    dynamic var route: Route!
    var routeItems: [RouteItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        numberTextField.window?.makeFirstResponder(numberTextField)
        validateTextFields()
    }
    
    func setInitialObject(_ object: Model) {
        route = object as! Route
    }
    
    func getResultObject() -> Model {

        route.number = numberTextField.integerValue
        route.routeItems = routeItems
        return route
    }
    
    func loadStations(for string: String, completion: @escaping ([Station]) -> ()) {
        let token = userAccountManager.token!
        requestManager.load(page: 1, limit: 30, token: token, filters: ["name": string]) { (success: Bool, result: Results<Station>?, error: Error?) in
            if success, let stations = result?.data {
                completion(stations)
            } else {
                completion([])
            }
        }
    }
    
    func validateTextFields() {
        let hasNumber = !numberTextField.stringValue.isEmpty
        let numberOfItems = routeItems.count >= 2
        let validItems = routeItems.filter { $0.station == nil }.count == 0
        delegate?.changeValidation(isValid: hasNumber && numberOfItems && validItems)
    }
    
    @IBAction func addButtonClick(_ sender: Any) {
        routeItems.append(RouteItem())
        tableView.reloadData()
    }
    @IBAction func removeButtonClick(_ sender: Any) {
        routeItems.removeLast()
        tableView.reloadData()
    }
}

//MARK: - NSTableViewDataSource
extension EditRouteViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return routeItems.count
    }
}

//MARK: - NSTableViewDelegate
extension EditRouteViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.makeView(withIdentifier: StationCellIdentifier, owner: self) as! StationTableCellView
        let item = routeItems[row]
        cellView.stationCombobox.stringValue = item.stationName
        cellView.arrivalTime.dateValue = item.arrivalTime
        cellView.departureTime.dateValue = item.departureTime
        cellView.delegate = self
        cellView.stationCombobox.isEditable = true
        return cellView
    }
    
    func tableView(_ tableView: NSTableView, selectionIndexesForProposedSelection proposedSelectionIndexes: IndexSet) -> IndexSet {
        return IndexSet()
    }
}

//MARK: - StationTableCellViewDelegate
extension EditRouteViewController: StationTableCellViewDelegate {
    
    func stationTableCellView(_ cellView: StationTableCellView, didChangeArrivalTime time: Date) {
        let index = tableView.row(for: cellView)
        let item = routeItems[index]
        item.arrivalTime = time
    }
    func stationTableCellView(_ cellView: StationTableCellView, didChangeDepartureTime time: Date) {
        let index = tableView.row(for: cellView)
        let item = routeItems[index]
        item.departureTime = time
    }
    func stationTableCellView(_ cellView: StationTableCellView, didChangeStationText text: String) {
        let index = tableView.row(for: cellView)
        let item = routeItems[index]
        item.stationName = text
        cellView.spinner.startAnimation(self)
        loadStations(for: text) { stations in
            cellView.spinner.stopAnimation(self)
            cellView.stationCombobox.removeAllItems()
            cellView.stationCombobox.addItems(withObjectValues: stations.map { $0.name })
            if let first = stations.first, first.name.lowercased() == text.lowercased() {
                item.station = first
            } else {
                item.station = nil
            }
            self.validateTextFields()
        }
    }
}

//MARK: - NSComboBoxDelegate
extension EditRouteViewController: NSComboBoxDelegate {
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        let combobox = notification.object as! NSComboBox
        combobox.stringValue = combobox.objectValueOfSelectedItem as! String
        validateTextFields()
    }
}

//MARK: - NSTextFieldDelegate
extension EditRouteViewController: NSTextFieldDelegate {
    
    override func controlTextDidChange(_ obj: Notification) {

        validateTextFields()
    }
}
