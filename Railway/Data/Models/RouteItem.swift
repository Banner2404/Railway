//
//  RouteItem.swift
//  Railway
//
//  Created by Соболь Евгений on 12/5/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class RouteItem: Codable {
    
    var stationName: String = ""
    var station: Station?
    var arrivalTime = Date()
    var departureTime = Date()
    
    init() {
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        self.station = Station(id: id, name: name)
        let departureTime = try container.decode(String.self, forKey: .departureTime)
        guard let depaptureDate = DateFormatter.HHmmSS.date(from: departureTime) else {
            throw DecodingError.dataCorruptedError(forKey: .departureTime, in: container, debugDescription: "Incorrect departure time")
        }
        let arrivalTime = try container.decode(String.self, forKey: .arrivalTime)
        guard let arrivalDate = DateFormatter.HHmmSS.date(from: arrivalTime) else {
            throw DecodingError.dataCorruptedError(forKey: .arrivalTime, in: container, debugDescription: "Incorrect arrival time")
        }
        self.departureTime = depaptureDate
        self.arrivalTime = arrivalDate
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let station = self.station {
            try container.encode(station.id, forKey: .id)
            try container.encode(station.name, forKey: .name)
        }
        let departureString = DateFormatter.HHmmSS.string(from: departureTime)
        let arrivalString = DateFormatter.HHmmSS.string(from: arrivalTime)
        try container.encode(departureString, forKey: .departureTime)
        try container.encode(arrivalString, forKey: .arrivalTime)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case arrivalTime = "arrival_time"
        case departureTime = "departure_time"
    }
}
