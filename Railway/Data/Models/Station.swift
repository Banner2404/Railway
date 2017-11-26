//
//  Station.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class Station: NSObject, Codable, NSCopying {
    
    @objc
    var id: Int
    @objc
    var name: String
    
    required override convenience init() {
        self.init(id: 0, name: "")
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Station(id: id, name: name)
    }
}
