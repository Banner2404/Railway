//
//  UserAccountManager.swift
//  Railway
//
//  Created by Соболь Евгений on 12/3/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class UserAccountManager {
    
    static let shared = UserAccountManager()

    var user: User?
    
    var token: String? {
        guard let user = user else { return nil }
        return "\(ApiKey.Bearer) \(user.token)"
    }
}
