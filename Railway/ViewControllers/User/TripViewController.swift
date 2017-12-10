//
//  TripViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 12/10/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class TripViewController: EditTableViewController {

    @IBOutlet weak var fromCombobox: NSComboBox!
    @IBOutlet weak var toCombobox: NSComboBox!
    @IBOutlet weak var datePicker: NSDatePicker!
    
    var helperMessage = "Setup new route info:"
    weak var delegate: AddTicketChildViewControllerDelegate?
    
    var fromStation: Station?
    var toStation: Station?
    
    class func loadFromStoryboard() -> Self {
        return loadFromStoryboard(name: "User")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validate()
        datePicker.dateValue = Date()
    }
    
    func getInfo() -> (from: Station, to: Station, date: Date) {
        return (fromStation!, toStation!, datePicker.dateValue)
    }
    
    func validate() {
        delegate?.changeValidation(isValid: fromStation != nil && toStation != nil)
    }
    
    func loadDepartureStations(text: String) {
        load(filters: ["name": text]) { (stations: [Station]) in
            self.fromCombobox.removeAllItems()
            self.fromCombobox.addItems(withObjectValues: stations.map { $0.name })
            if let first = stations.first, first.name.lowercased() == text.lowercased() {
                self.fromStation = first
            } else {
                self.fromStation = nil
            }
            self.validate()
        }
    }
    
    func loadArrivalStations(text: String) {
        load(filters: ["name": text]) { (stations: [Station]) in
            self.toCombobox.removeAllItems()
            self.toCombobox.addItems(withObjectValues: stations.map { $0.name })
            if let first = stations.first, first.name.lowercased() == text.lowercased() {
                self.toStation = first
            } else {
                self.toStation = nil
            }
            self.validate()
        }
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        if let combobox = obj.object as? NSComboBox, combobox == fromCombobox {
            let text = fromCombobox.stringValue
            loadDepartureStations(text: text)
        }
        if let combobox = obj.object as? NSComboBox, combobox == toCombobox {
            let text = toCombobox.stringValue
            loadArrivalStations(text: text)
        }
    }
    
}

//MARK: - NSComboBoxDelegate
extension TripViewController: NSComboBoxDelegate {
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        if let combobox = notification.object as? NSComboBox, combobox == fromCombobox {
            let text = fromCombobox.stringValue
            loadDepartureStations(text: text)
        }
        if let combobox = notification.object as? NSComboBox, combobox == toCombobox {
            let text = toCombobox.stringValue
            loadArrivalStations(text: text)
        }
    }
}
