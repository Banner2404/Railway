//
//  AccountsViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 11/26/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class AccountsViewController: TableViewController {

    class func loadFromStoryboard() -> Self {
        return loadFromAdminStoryboard()
    }

    override func makeRequest(page: Int, limit: Int, completion: @escaping (_ success: Bool, _ totalCount: Int?, _ data: [Model]?, _ error: Error?) -> Void) {
        let token = userAccountManager.token ?? ""
        requestManager.load(page: page, limit: limit, token: token) { (success: Bool, result: Results<Account>?, error: Error?) in
            completion(success, result?.meta.totalCount, result?.data, error)
        }
    }
}


