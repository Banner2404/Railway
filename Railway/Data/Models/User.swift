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
    
    init(withToken token: String) {
        self.token = token
    }
}
