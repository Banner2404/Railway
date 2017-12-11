//
//  UserRequests.swift
//  Railway
//
//  Created by Соболь Евгений on 12/10/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class UserRequests {
    
    static var isUser: Bool {
        return UserAccountManager.shared.user?.type == "ADMIN"
    }
    
    static func trains(from: Int, to: Int, date: String, token: String) -> URLRequest {
        var url = URL(string: ApiURL.Host)!
        if isUser {
            url.appendPathComponent(ApiPath.Admin)
        } else {
            url.appendPathComponent(ApiPath.Client)
        }
        url.appendPathComponent(ApiPath.Train)
        
        var request = URLRequest.getRequest(withUrl: url)
        request.addValue(token, forHTTPHeaderField: ApiKey.Authorization)
        return request
    }
}
