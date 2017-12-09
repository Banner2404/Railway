//
//  CarriageTableCellView.swift
//  Railway
//
//  Created by Соболь Евгений on 12/10/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

protocol CarriageTableCellViewDelegate: class {
    
    func carriageTableCellView(_ cellView: CarriageTableCellView, didChangeCarriageType type: String)
    func carriageTableCellView(_ cellView: CarriageTableCellView, didChangeNumberOfSeats seats: Int)
}

class CarriageTableCellView: NSTableCellView {
    
    @IBOutlet weak var popup: NSPopUpButton!
    @IBOutlet weak var seatsTextField: NSTextField!
    weak var delegate: CarriageTableCellViewDelegate?
    
    @IBAction
    func popupDidChange(_ sender: Any) {
        let type = popup.selectedItem?.title ?? ""
        delegate?.carriageTableCellView(self, didChangeCarriageType: type)
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        let number = seatsTextField.integerValue
        delegate?.carriageTableCellView(self, didChangeNumberOfSeats: number)
    }
    
}
