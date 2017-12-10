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
    func carriageTableCellView(_ cellView: CarriageTableCellView, didChangeNumber number: Int)
}

class CarriageTableCellView: NSTableCellView {
    
    @IBOutlet weak var popup: NSPopUpButton!
    @IBOutlet weak var seatsTextField: NSTextField!
    @IBOutlet weak var numberTextField: NSTextField!
    weak var delegate: CarriageTableCellViewDelegate?
    
    @IBAction
    func popupDidChange(_ sender: Any) {
        let type = popup.selectedItem?.title ?? ""
        delegate?.carriageTableCellView(self, didChangeCarriageType: type)
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        if let object = obj.object as? NSTextField, object == seatsTextField {
            let number = seatsTextField.integerValue
            delegate?.carriageTableCellView(self, didChangeNumberOfSeats: number)
        } else {
            let number = numberTextField.integerValue
            delegate?.carriageTableCellView(self, didChangeNumber: number)
        }
        
    }
    
}
