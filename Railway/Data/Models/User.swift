//
//  User.swift
//  Railway
//
//  Created by Соболь Евгений on 12/3/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class User: Codable {
    
    let token: String
    let type = "ADMIN"
    
    init(withToken token: String, type: String) {
        self.token = token
        //self.type = type
    }
}
