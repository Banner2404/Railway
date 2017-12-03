//
//  PassengersViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 11/27/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class PassengersViewController: TableViewController {

    class func loadFromStoryboard() -> Self {
        return loadFromAdminStoryboard()
    }
    
    override func makeRequest(page: Int, limit: Int, completion: @escaping (_ success: Bool, _ totalCount: Int?, _ data: [Model]?, _ error: Error?) -> Void) {
        let token = userAccountManager.token ?? ""
        requestManager.load(page: page, limit: limit, token: token) { (success: Bool, result: Results<Passenger>?, error: Error?) in
            completion(success, result?.meta.totalCount, result?.data, error)
        }
    }
    
}
