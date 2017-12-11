//
//  Result.swift
//  Railway
//
//  Created by Соболь Евгений on 12/11/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class Result<T: Decodable>: Decodable {
    
    let data: T
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        data = try container.decode(T.self, forKey: .data)
    }
    
    enum Keys: String, CodingKey {
        case data = "data"
    }
}
