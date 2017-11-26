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
    var accountTypeString: String
    
    var accountType: AccountType {
        get {
            return AccountType(rawValue: accountTypeString)!
        }
        set {
            accountTypeString = newValue.rawValue
        }
    }
    
    required override convenience init() {
        self.init(id: 0, username: "", password: "", accountTypeString: "USER")
    }
    
    init(id: Int, username: String, password: String, accountTypeString: String) {
        self.id = id
        self.username = username
        self.password = password
        self.accountTypeString = accountTypeString
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
        password = try container.decodeIfPresent(String.self, forKey: .password) ?? ""
        accountTypeString = try container.decode(String.self, forKey: .accountTypeString)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Account(id: id, username: username, password: password, accountTypeString: accountTypeString)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case password
        case accountTypeString = "type"
    }
    
    enum AccountType: String, Codable {
        case user = "USER"
        case admin = "ADMIN"
    }
}
