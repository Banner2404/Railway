//
//  TableViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 11/26/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class TableViewController: NSViewController, BaseViewController {

    @IBOutlet var arrayController: NSArrayController?

    var totalCount = 0
    let limit = 150
    var page = 0
    var isLoading = false
    var searchText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    override func validateToolbarItem(_ item: NSToolbarItem) -> Bool {
        if item.itemIdentifier == ToolbarIdentifier.Search {
            return isSearchSupported()
        }
        return !(arrayController?.selectionIndexes.isEmpty ?? true)
    }
    
    func isSearchSupported() -> Bool {
        return false
    }
    
    func loadData() {
        page += 1
        isLoading = true
        makeRequest(page: page, limit: limit, search: searchText) { (success, totalCount, data, error) in
            self.isLoading = false
            if success, let totalCount = totalCount, let data = data {
                self.totalCount = totalCount
                self.add(data)
            } else {
                print(error ?? "Unable to load stations")
            }
        }
    }
    
    func makeRequest(page: Int, limit: Int, search: String, completion: @escaping (_ success: Bool, _ totalCount: Int?, _ data: [Model]?, _ error: Error?) -> Void) {
        fatalError("makeRequest not implemented")
    }
    
    func add(_ items: [Model]) {
        if arrayController?.content == nil {
            arrayController?.content = items
            return
        } else {
            arrayController?.add(contentsOf: items)
        }
    }
    
}

//MARK: - NSTableViewDelegate
extension TableViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        if isLoading { return nil }
        guard let currentStations = arrayController?.content as? [Station] else { return nil }
        if totalCount == currentStations.count { return nil }
        if currentStations.count - row > 5 { return nil}
        loadData()
        return nil
    }
}

//MARK: - AdminChildViewController
extension TableViewController: AdminChildViewController {
    
    func selectedObject() -> Any? {
        return arrayController?.selectedObjects.first
    }
    
    func reloadData() {
        page = 0
        arrayController?.content = nil
        loadData()
    }
    
    func search(_ text: String) {
        searchText = text
        if isSearchSupported() {
            reloadData()
        }
    }
}
