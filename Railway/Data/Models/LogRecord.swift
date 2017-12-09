//
//  LogRecord.swift
//  Railway
//
//  Created by Соболь Евгений on 12/9/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class LogRecord: NSObject, Codable, NSCopying {
    
    @objc
    var id: Int
    @objc
    var type: String
    @objc
    var targetID: Int
    @objc
    var initiatorID: Int
    @objc
    var initiatorName: String
    
    required override convenience init() {
        self.init(id: 0, type: "", targetID: 0, initiatorID: 0, initiatorName: "")
    }
    
    init(id: Int, type: String, targetID: Int, initiatorID: Int, initiatorName: String) {
        self.id = id
        self.type = type
        self.targetID = targetID
        self.initiatorID = initiatorID
        self.initiatorName = initiatorName
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.type = try container.decode(String.self, forKey: .type)
        self.targetID = try container.decode(Int.self, forKey: .targetID)
        let initiator = try container.nestedContainer(keyedBy: CodingKeys.Initiator.self, forKey: .initiator)
        self.initiatorID = try initiator.decode(Int.self, forKey: .id)
        self.initiatorName = try initiator.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        return
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return LogRecord(id: id, type: type, targetID: targetID, initiatorID: initiatorID, initiatorName: initiatorName)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case targetID = "target_id"
        case initiator
        
        enum Initiator: String, CodingKey {
            case name
            case id
        }
    }
    
}
