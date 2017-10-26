//
//  StationsViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class StationsViewController: NSViewController, BaseViewController {

    @IBOutlet var stationsArrayController: NSArrayController!
    @IBOutlet weak var tableView: NSTableView!
    var totalCount = 0
    let limit = 150
    var page = 0
    var isLoading = false
    
    class func loadFromStoryboard() -> Self {
        return loadFromAdminStoryboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    override func validateToolbarItem(_ item: NSToolbarItem) -> Bool {
        return !stationsArrayController.selectionIndexes.isEmpty
    }
    
}

//MARK: - Private
private extension StationsViewController {
    
    func loadStations() {
        page += 1
        isLoading = true
        requestManager.loadStations(page: page, limit: limit) { [weak self] (success, stations, error) in
            self?.isLoading = false
            if success, let stations = stations {
                self?.totalCount = stations.meta.totalCount
                self?.add(stations.stations)
            } else {
                print(error ?? "Unable to load stations")
            }
        }
    }
    
    func add(_ items: [Station]) {
        if stationsArrayController.content == nil {
            stationsArrayController.content = items
            return
        } else {
            stationsArrayController.add(contentsOf: items)
        }
    }
}

//MARK: - NSTableViewDelegate
extension StationsViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        if isLoading { return nil }
        guard let currentStations = stationsArrayController.content as? [Station] else { return nil }
        if totalCount == currentStations.count { return nil }
        if currentStations.count - row > 5 { return nil}
        loadStations()
        return nil
    }
}

//MARK: - AdminChildViewController
extension StationsViewController: AdminChildViewController {
    
    func reloadData() {
        page = 0
        stationsArrayController.content = nil
        loadStations()
    }
}
