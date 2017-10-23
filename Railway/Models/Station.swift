//
//  Station.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class Station: NSObject, Codable {
    
    @objc
    var id: Int
    @objc
    var name: String
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
    
}
