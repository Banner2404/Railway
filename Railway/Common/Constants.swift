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
    static let Page = "page"
    static let Limit = "limit"
}

struct ToolbarIdentifier {
    static let Add = NSToolbarItem.Identifier(rawValue: "add")
    static let Edit = NSToolbarItem.Identifier(rawValue: "edit")
}
