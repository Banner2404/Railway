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
    @objc
    var departureStation: Station?
    @objc
    var arrivalStation: Station?
    @objc
    var departureTime: Date
    @objc
    var arrivalTime: Date
    @objc
    var seats: Int
    @objc
    var availableSeats: Int
    @objc
    var carriages: [Carriage]
    @objc
    var routeID = 0
    @objc
    var date: Date
    
    required override convenience init() {
        self.init(id: 0, number: 0, departureStation: nil, arrivalStation: nil, departureTime: Date(), arrivalTime: Date(), seats: 0, availableSeats: 0, carriages: [], route: 0, date: Date())
    }
    
    init(id: Int, number: Int, departureStation: Station?, arrivalStation: Station?, departureTime: Date, arrivalTime: Date, seats: Int, availableSeats: Int, carriages: [Carriage], route: Int, date: Date) {
        self.id = id
        self.number = number
        self.departureStation = departureStation
        self.arrivalStation = arrivalStation
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.seats = seats
        self.availableSeats = availableSeats
        self.carriages = carriages
        self.routeID = route
        self.date = date
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Train(id: id, number: number, departureStation: departureStation, arrivalStation: arrivalStation, departureTime: departureTime, arrivalTime: arrivalTime, seats: seats, availableSeats: availableSeats, carriages: carriages, route: routeID, date: Date())
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.number = try container.decode(Int.self, forKey: .number)
        self.departureStation = try container.decode(Station.self, forKey: .departureStation)
        self.arrivalStation = try container.decode(Station.self, forKey: .arrivalStation)
        self.seats = try container.decode(Int.self, forKey: .seats)
        self.availableSeats = try container.decode(Int.self, forKey: .availableSeats)

        let departureTime = try container.decode(String.self, forKey: .departureTime)
        guard let depaptureDate = DateFormatter.HHmmSS.date(from: departureTime) else {
            throw DecodingError.dataCorruptedError(forKey: .departureTime, in: container, debugDescription: "Incorrect departure time")
        }
        let arrivalTime = try container.decode(String.self, forKey: .arrivalTime)
        guard let arrivalDate = DateFormatter.HHmmSS.date(from: arrivalTime) else {
            throw DecodingError.dataCorruptedError(forKey: .arrivalTime, in: container, debugDescription: "Incorrect arrival time")
        }
        let date = try container.decode(String.self, forKey: .date)
        guard let scheduleDate = DateFormatter.YYYYMMDD.date(from: date) else {
            throw DecodingError.dataCorruptedError(forKey: .arrivalTime, in: container, debugDescription: "Incorrect schedule time")
        }
        self.date = scheduleDate
        self.departureTime = depaptureDate
        self.arrivalTime = arrivalDate
        self.carriages = (try? container.decode([Carriage].self, forKey: .carriages)) ?? []
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(number, forKey: .number)
        try container.encode(departureStation, forKey: .departureStation)
        try container.encode(arrivalStation, forKey: .arrivalStation)
        let departureString = DateFormatter.HHmmSS.string(from: departureTime)
        let arrivalString = DateFormatter.HHmmSS.string(from: arrivalTime)
        let scheduleDate = DateFormatter.YYYYMMDD.string(from: date)
        try container.encode(departureString, forKey: .departureTime)
        try container.encode(arrivalString, forKey: .arrivalTime)
        try container.encode(scheduleDate, forKey: .date)
        try container.encode(seats, forKey: .seats)
        try container.encode(availableSeats, forKey: .availableSeats)
        try container.encode(carriages, forKey: .carriages)
        try container.encode(routeID, forKey: .route)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case number
        case departureStation = "departure_station"
        case arrivalStation = "destination_station"
        case departureTime = "departure_time"
        case arrivalTime = "arrival_time"
        case seats
        case availableSeats = "free_seats"
        case carriages
        case route = "route_id"
        case date = "schedule_date"
    }
    
}
