//
//  Passenger.swift
//  Railway
//
//  Created by Соболь Евгений on 11/27/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class Passenger: NSObject, Codable, NSCopying {
    
    @objc
    var id: Int
    @objc
    var name: String
    @objc
    var passport: String
    
    required override convenience init() {
        self.init(id: 0, name: "", passport: "")
    }
    
    init(id: Int, name: String, passport: String) {
        self.id = id
        self.name = name
        self.passport = passport
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.passport = (try? container.decode(String.self, forKey: .passport)) ?? ""
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Passenger(id: id, name: name, passport: passport)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case passport = "passport_no"
    }
}
