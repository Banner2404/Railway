//
//  StationsRequests.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class StationRequests {
    
    static func getStations() -> URLRequest {
        var url = URL(string: ApiURL.Host)!
        url.appendPathComponent(ApiPath.Stations)
        return URLRequest.getRequest(withUrl: url)
    }
}
