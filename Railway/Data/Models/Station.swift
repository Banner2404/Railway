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
        self.init(name: "", id: 0)
    }
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Station(name: name, id: id)
    }
}
