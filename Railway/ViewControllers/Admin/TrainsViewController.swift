//
//  TrainsViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 12/9/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class TrainsViewController: TableViewController {

    class func loadFromStoryboard() -> Self {
        return loadFromAdminStoryboard()
    }
    
    override func validateToolbarItem(_ item: NSToolbarItem) -> Bool {
        return false
    }
    
    override func makeRequest(page: Int, limit: Int, completion: @escaping (_ success: Bool, _ totalCount: Int?, _ data: [Model]?, _ error: Error?) -> Void) {
        let token = userAccountManager.token ?? ""
        requestManager.load(page: page, limit: limit, token: token) { (success: Bool, result: Results<LogRecord>?, error: Error?) in
            completion(success, result?.meta.totalCount, result?.data, error)
            
    
}
