//
//  EditTicketViewConroller.swift
//  Railway
//
//  Created by Соболь Евгений on 12/10/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class EditTicketViewController: EditTableViewController, FillViewController {
    
    var helperMessage = "Setup new ticket:"
    var delegate: FillViewControllerDelegate?
    
    @IBOutlet weak var passengerCombobox: NSComboBox!
    @IBOutlet weak var fromCombobox: NSComboBox!
    @IBOutlet weak var toCombobox: NSComboBox!
    @IBOutlet weak var seatTextField: NSTextField!
    
    @objc
    var ticket: Ticket!
    
    func setInitialObject(_ object: Model) {
        ticket = object as! Ticket
    }
    
    func getResultObject() -> Model {
        return ticket
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passengerCombobox.stringValue = ticket.passenger?.name ?? ""
        fromCombobox.stringValue = ticket.departureStation?.name ?? ""
        toCombobox.stringValue = ticket.arrivalStation?.name ?? ""
        seatTextField.stringValue = "\(ticket.seatID)"
        validate()
    }
    
    func validate() {
        let hasSeat = ticket.seatID != 0
        let hasDeparture = ticket.departureStation != nil
        let hasArrival = ticket.arrivalStation != nil
        let hasPassenger = ticket.passenger != nil
        delegate?.changeValidation(isValid: hasSeat && hasDeparture && hasArrival && hasPassenger)
    }
    
    func loadPassenger(text: String) {
        load(filters: ["name": text]) { (passengers: [Passenger]) in
            self.passengerCombobox.removeAllItems()
            self.passengerCombobox.addItems(withObjectValues: passengers.map { $0.name })
            if let first = passengers.first, first.name.lowercased() == text.lowercased() {
                self.ticket.passenger = first
            } else {
                self.ticket.passenger = nil
            }
            self.validate()
        }
    }
    
    func loadDepartureStations(text: String) {
        load(filters: ["name": text]) { (stations: [Station]) in
            self.fromCombobox.removeAllItems()
            self.fromCombobox.addItems(withObjectValues: stations.map { $0.name })
            if let first = stations.first, first.name.lowercased() == text.lowercased() {
                self.ticket.departureStation = first
            } else {
                self.ticket.departureStation = nil
            }
            self.validate()
        }
    }
    
    func loadArrivalStations(text: String) {
        load(filters: ["name": text]) { (stations: [Station]) in
            self.toCombobox.removeAllItems()
            self.toCombobox.addItems(withObjectValues: stations.map { $0.name })
            if let first = stations.first, first.name.lowercased() == text.lowercased() {
                self.ticket.arrivalStation = first
            } else {
                self.ticket.arrivalStation = nil
            }
            self.validate()
        }
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        if let object = obj.object as? NSTextField {
            let number = object.integerValue
            ticket.seatID = number
            validate()
        }
        if let object = obj.object as? NSComboBox {
            let text = object.stringValue
            if object == passengerCombobox {
                loadPassenger(text: text)
            } else if object == fromCombobox {
                loadDepartureStations(text: text)
            } else {
                loadArrivalStations(text: text)
            }
        }
    }
}

//MARK: - NSComboBox
extension EditTicketViewController: NSComboBoxDelegate {
    
    func comboBoxSelectionDidChange(_ notification: Notification) {
        if let object = notification.object as? NSComboBox {
            let text = object.stringValue
            if object == passengerCombobox {
                loadPassenger(text: text)
            } else if object == fromCombobox {
                loadDepartureStations(text: text)
            } else {
                loadArrivalStations(text: text)
            }
        }
    }
}
