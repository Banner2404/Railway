//
//  Ticket.swift
//  Railway
//
//  Created by Соболь Евгений on 12/10/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class Ticket: NSObject, Codable, NSCopying {
    
    @objc
    var id: Int
    
    required override convenience init() {
        self.init(id: 0)
    }
    
    init(id: Int) {
        self.id = id
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Ticket(id: id)
    }
    
}
