//
//  Constants.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

struct ApiURL {
    static let Host = "http://207.154.238.176:8080/api/v1/"
}

struct ApiPath {
    static let Stations = "stations"
    static let Accounts = "accounts"
    static let Passenger = "passengers"
    static let LogRecord = "logs"
    static let Train = "trains"
    static let Tickets = "tickets"
    static let Routes = "routes"
    static let Page = "page"
    static let Limit = "limit"
    static let Auth = "auth"
    static let SignIn = "signin"
    static let Client = "client"
    static let Admin = "admin"

}

struct ApiKey {
    static let Authorization = "Authorization"
    static let Bearer = "Bearer"
}

struct ToolbarIdentifier {
    static let Add = NSToolbarItem.Identifier(rawValue: "add")
    static let Edit = NSToolbarItem.Identifier(rawValue: "edit")
    static let Search = NSToolbarItem.Identifier(rawValue: "search")
}
