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
        return route
    }
    
    func loadStations(for string: String, completion: @escaping ([Station]) -> ()) {
        let token = userAccountManager.token!
        requestManager.load(page: 1, limit: 30, token: token) { (success: Bool, result: Results<Station>?, error: Error?) in
            if success, let stations = result?.data {
                completion(stations)
            } else {
                completion([])
            }
        }
    }
    
    func validateTextFields() {
        
    }
    @IBAction func addButtonClick(_ sender: Any) {
        routeItems.append(RouteItem())
        tableView.reloadData()
    }
    @IBAction func removeButtonClick(_ sender: Any) {
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
        cellView.stationCombobox.stringValue = item.station?.name ?? ""
        cellView.arrivalTime.dateValue = item.arrivalTime
        cellView.departureTime.dateValue = item.departureTime
        cellView.delegate = self
        return cellView
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
        loadStations(for: text) { stations in
            cellView.stationCombobox.removeAllItems()
            cellView.stationCombobox.addItems(withObjectValues: stations.map { $0.name })
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
