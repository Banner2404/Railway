//
//  Ticket.swift
//  Railway
//
//  Created by Соболь Евгений on 12/10/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class Ticket: NSObject, Codable, NSCopying {
    
    @objc
    var id: Int
    @objc
    var seatID: Int
    @objc
    var departureStation: Station?
    @objc
    var arrivalStation: Station?
    @objc
    var passenger: Passenger?
    
    required override convenience init() {
        self.init(id: 0, seatID: 0, departureStation: nil, arrivalStation: nil, passenger: nil)
    }
    
    init(id: Int, seatID: Int, departureStation: Station?, arrivalStation: Station?, passenger: Passenger?) {
        self.id = id
        self.seatID = seatID
        self.departureStation = departureStation
        self.arrivalStation = arrivalStation
        self.passenger = passenger
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.seatID = try container.decode(Int.self, forKey: .seatID)
        self.departureStation = try container.decode(Station.self, forKey: .departureStation)
        self.arrivalStation = try container.decode(Station.self, forKey: .arrivalStation)
        self.passenger = try container.decode(Passenger.self, forKey: .passenger)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(departureStation?.id ?? 0, forKey: .departureStationID)
        try container.encode(arrivalStation?.id ?? 0, forKey: .arrivalStationID)
        try container.encode(passenger?.id ?? 0, forKey: .passengerID)
        try container.encode(seatID, forKey: .seatID)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Ticket(id: id, seatID: seatID, departureStation: departureStation, arrivalStation: arrivalStation, passenger: passenger)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case seatID = "seat_id"
        case departureStation = "departure_station"
        case arrivalStation = "arrival_station"
        case passenger
        case departureStationID = "departure_station_id"
        case arrivalStationID = "arrival_station_id"
        case passengerID = "passenger_id"

    }
}
