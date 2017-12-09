//
//  EditTableViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 12/10/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class EditTableViewController: NSViewController, BaseViewController {

    func load<T: Model>(filters: [String: String], completion: @escaping ([T]) -> ()) {
        let token = userAccountManager.token!
        requestManager.load(page: 1, limit: 30, token: token, filters: filters) { (success: Bool, result: Results<T>?, error: Error?) in
            if success, let stations = result?.data {
                completion(stations)
            } else {
                completion([])
            }
        }
    }
}
