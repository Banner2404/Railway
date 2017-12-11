//
//  SelectSeatViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 12/11/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class SelectSeatViewController: NSViewController, BaseViewController {

    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet var arrayController: NSArrayController!
    @IBOutlet weak var seatPopup: NSPopUpButton!
    @IBOutlet weak var seatLabel: NSTextField!
    
    var helperMessage = "Setup new route info:"
    weak var delegate: AddTicketChildViewControllerDelegate?
    var train: Train!
    var selectedCarriage: Carriage?
    
    class func loadFromStoryboard() -> Self {
        return loadFromStoryboard(name: "User")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCarriages(for: train)
        validate()
        validateAll()
    }
    
    func loadCarriages(for train: Train) {
        let token = userAccountManager.token ?? ""
        requestManager.load(id: train.id, token: token) { (success: Bool, train: Result<Train>?, error: Error?) in
            self.arrayController.add(contentsOf: train?.data.carriages ?? [])
        }
    }
    @IBAction func selectionChanged(_ sender: Any) {
        selectedCarriage = arrayController.selectedObjects.first as? Carriage
        validate()
    }
    @IBAction func popupChanged(_ sender: Any) {
        validateAll()
    }
    
    func getInfo() -> (train: Train, carriage: Carriage, seat: Int)? {
        guard let train = self.train else { return nil }
        guard let carriage = self.selectedCarriage else { return nil }
        guard let seat = Int(self.seatPopup.titleOfSelectedItem ?? "") else { return nil }
        return (train, carriage, seat)
    }
    
    func validate() {
        if let carriage = selectedCarriage {
            seatLabel.isEnabled = true
            seatPopup.isEnabled = true
            seatPopup.removeAllItems()
            seatPopup.addItems(withTitles: carriage.seats.sorted().map { "\($0)"})
        } else {
            seatPopup.removeAllItems()
            seatLabel.isEnabled = false
            seatPopup.isEnabled = false
        }
    }
    
    func validateAll() {
        let hasSelectedCarriage = selectedCarriage != nil
        let hasSelectedSeat = seatPopup.selectedItem != nil
        delegate?.changeValidation(isValid: hasSelectedCarriage && hasSelectedSeat)
    }
}
