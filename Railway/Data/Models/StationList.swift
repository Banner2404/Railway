//
//  StationList.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class StationList: Codable {
    
    class Meta: Codable {
        let totalCount: Int
        
        enum CodingKeys: String, CodingKey {
            case totalCount = "quantity"
        }
    }
    
    let meta: Meta
    let stations: [Station]
}
