//
//  StationsViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class StationsViewController: TableViewController {

    class func loadFromStoryboard() -> Self {
        return loadFromAdminStoryboard()
    }
    
    override func makeRequest(page: Int, limit: Int, completion: @escaping (_ success: Bool, _ totalCount: Int?, _ data: [Model]?, _ error: Error?) -> Void) {
        let token = userAccountManager.token ?? ""
        requestManager.load(page: page, limit: limit, token: token) { (success: Bool, result: Results<Station>?, error: Error?) in
            completion(success, result?.meta.totalCount, result?.data, error)
        }
    }
}
