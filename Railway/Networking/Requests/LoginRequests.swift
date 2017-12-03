//
//  LoginRequests.swift
//  Railway
//
//  Created by Соболь Евгений on 12/3/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class LoginRequests {
    
    static func login(username: String, password: String) -> URLRequest {
        var url = URL(string: ApiURL.Host)!
        url.appendPathComponent(ApiPath.Auth)
        
        let body = ["username": username, "password": password]
        let data = try? JSONSerialization.data(withJSONObject: body, options: [])
        return URLRequest.postRequest(withUrl: url, body: data)
    }
}
