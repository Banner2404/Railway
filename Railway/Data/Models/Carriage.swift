//
//  Carriage.swift
//  Railway
//
//  Created by Соболь Евгений on 12/10/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class Carriage: NSObject, Codable, NSCopying {
    
    @objc
    var number: Int
    @objc
    var type: String
    @objc
    var seats: [Int]
    
    required override convenience init() {
        self.init(number: 0, type: "", seats: [])
    }
    
    init(number: Int, type: String, seats: [Int]) {
        self.number = number
        self.type = type
        self.seats = seats
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Carriage(number: number, type: type, seats: seats)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.number = try container.decode(Int.self, forKey: .number)
        self.type = try container.decode(String.self, forKey: .type)
        self.seats = try container.decode([Int].self, forKey: .seats)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(number, forKey: .number)
        try container.encode(type, forKey: .type)
        try container.encode(seats.count, forKey: .seats)
    }
    
    enum CodingKeys: String, CodingKey {
        case number
        case type
        case seats
    }
    
}

