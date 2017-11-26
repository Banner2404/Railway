//
//  StationList.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class Results<T: Decodable>: Decodable {
    
    class Meta: Decodable {
        let totalCount: Int
        
        enum CodingKeys: String, CodingKey {
            case totalCount = "quantity"
        }
        
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            totalCount = try container.decode(Int.self, forKey: .totalCount)
        }
    }
    
    let meta: Meta
    let data: [T]
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        meta = try container.decode(Meta.self, forKey: .meta)
        data = try container.decode([T].self, forKey: .data)
    }
    
    enum Keys: String, CodingKey {
        case meta = "meta"
        case data = "data"
    }
}
