//
//  URLRequest.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

extension URLRequest {
    
    init(withUrl url: URL, httpMethod: String = "GET", body: [String: Any]? = nil) {
        self.init(url: url)
        self.httpMethod = httpMethod
        if let body = body {
            self.httpBody = try? JSONSerialization.data(withJSONObject: body)
            self.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
    
    static func getRequest(withUrl url: URL) -> URLRequest {
        return URLRequest(withUrl: url, httpMethod: "GET")
    }
    
    static func postRequest(withUrl url: URL, body: [String: Any]?) -> URLRequest {
        return URLRequest(withUrl: url, httpMethod: "POST", body: body)
    }
    
    static func putRequest(withUrl url: URL, body: [String: Any]?) -> URLRequest {
        return URLRequest(withUrl: url, httpMethod: "PUT", body: body)
    }
    
    static func deleteRequest(withUrl url: URL) -> URLRequest {
        return URLRequest(withUrl: url, httpMethod: "DELETE")
    }
}
