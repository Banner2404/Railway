//
//  Model.swift
//  Railway
//
//  Created by Соболь Евгений on 11/26/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

protocol Model: Codable {
    init()
    
    var id: Int { get }
    static var apiPath: String { get }
}
extension Station: Model {
    static var apiPath = ApiPath.Stations
}
extension Account: Model {
    static var apiPath = ApiPath.Accounts
}
