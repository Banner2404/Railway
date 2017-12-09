//
//  Train.swift
//  Railway
//
//  Created by Соболь Евгений on 12/9/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class Train: NSObject, Codable, NSCopying {
    
    @objc
    var id: Int
    @objc
    var number: Int
    
    required override convenience init() {
        self.init(id: 0, number: 0)
    }
    
    init(id: Int, number: Int) {
        self.id = id
        self.number = number
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Train(id: id, number: number)
    }
    
}
