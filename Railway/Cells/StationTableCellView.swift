//
//  StationTableCellView.swift
//  Railway
//
//  Created by Соболь Евгений on 12/5/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

protocol StationTableCellViewDelegate: class {
    
    func stationTableCellView(_ cellView: StationTableCellView, didChangeArrivalTime: Date)
    func stationTableCellView(_ cellView: StationTableCellView, didChangeDepartureTime: Date)
    func stationTableCellView(_ cellView: StationTableCellView, didChangeStationText: String)
}

class StationTableCellView: NSTableCellView {

    weak var delegate: StationTableCellViewDelegate?
    
    @IBOutlet weak var stationCombobox: NSComboBox!
    @IBOutlet weak var arrivalTime: NSDatePicker!
    @IBOutlet weak var departureTime: NSDatePicker!
    @IBOutlet weak var spinner: NSProgressIndicator!
    
    @IBAction func arrivalTimeDidChange(_ sender: Any) {
        delegate?.stationTableCellView(self, didChangeArrivalTime: arrivalTime.dateValue)
    }
    @IBAction func departureTimeDidChange(_ sender: Any) {
        delegate?.stationTableCellView(self, didChangeDepartureTime: departureTime.dateValue)
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        delegate?.stationTableCellView(self, didChangeStationText: stationCombobox.stringValue)
    }
}
