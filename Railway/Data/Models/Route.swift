//
//  Route.swift
//  Railway
//
//  Created by Соболь Евгений on 12/3/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class Route: NSObject, Codable, NSCopying {
    
    @objc
    var id: Int
    @objc
    var number: Int
    @objc
    var departureStation: Station?
    @objc
    var arrivalStation: Station?
    @objc
    var departureTime: Date
    @objc
    var arrivalTime: Date
    
    required override convenience init() {
        self.init(id: 0, number: 0, departureStation: nil, arrivalStation: nil, departureTime: Date(), arrivalTime: Date())
        
    }
    
    init(id: Int, number: Int, departureStation: Station?, arrivalStation: Station?, departureTime: Date, arrivalTime: Date) {
        self.id = id
        self.number = number
        self.departureStation = departureStation
        self.arrivalStation = arrivalStation
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Route(id: id, number: number, departureStation: departureStation, arrivalStation: arrivalStation, departureTime: departureTime, arrivalTime: arrivalTime)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.number = try container.decode(Int.self, forKey: .number)
        self.departureStation = try container.decode(Station.self, forKey: .departureStation)
        self.arrivalStation = try container.decode(Station.self, forKey: .arrivalStation)
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
        try container.encode(id, forKey: .id)
        try container.encode(number, forKey: .number)
        try container.encode(departureStation, forKey: .departureStation)
        try container.encode(arrivalStation, forKey: .arrivalStation)
        let departureString = DateFormatter.HHmmSS.string(from: departureTime)
        let arrivalString = DateFormatter.HHmmSS.string(from: arrivalTime)
        try container.encode(departureString, forKey: .departureTime)
        try container.encode(arrivalString, forKey: .arrivalTime)
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case number
        case departureStation = "departure_station"
        case arrivalStation = "destination_station"
        case departureTime = "departure_time"
        case arrivalTime = "arrival_time"
    }
}
