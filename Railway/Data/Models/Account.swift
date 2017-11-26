//
//  Account.swift
//  Railway
//
//  Created by Соболь Евгений on 11/26/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class Account: NSObject, Codable, NSCopying {
    
    @objc
    var id: Int
    @objc
    var username: String
    @objc
    var password: String
    @objc
    var accountType: String
    
    required override convenience init() {
        self.init(id: 0, username: "", password: "", accountType: "")
    }
    
    init(id: Int, username: String, password: String, accountType: String) {
        self.id = id
        self.username = username
        self.password = password
        self.accountType = accountType
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Account(id: id, username: username, password: password, accountType: accountType)
    }
}
