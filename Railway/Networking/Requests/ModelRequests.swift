//
//  StationsRequests.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class ModelRequests<T: Model> {
    
    static func load(page: Int, limit: Int) -> URLRequest {
        var url = URL(string: ApiURL.Host)!
        url.appendPathComponent(T.urlPath)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = [
            URLQueryItem(name: ApiPath.Page, value: "\(page)"),
            URLQueryItem(name: ApiPath.Limit, value: "\(limit)"),
        ]
        
        return URLRequest.getRequest(withUrl: urlComponents.url!)
    }
    
    static func create(_ model: T) -> URLRequest {
        var url = URL(string: ApiURL.Host)!
        url.appendPathComponent(T.urlPath)
        let body = try? JSONEncoder().encode(model)
        return URLRequest.postRequest(withUrl: url, body: body)
    }
    
    static func update(_ model: T) -> URLRequest {
        var url = URL(string: ApiURL.Host)!
        url.appendPathComponent(T.urlPath)
        url.appendPathComponent("\(model.id)")
        
        let body = try? JSONEncoder().encode(model)
        return URLRequest.putRequest(withUrl: url, body: body)
    }
    
    static func delete(_ model: T) -> URLRequest {
        var url = URL(string: ApiURL.Host)!
        url.appendPathComponent(T.urlPath)
        url.appendPathComponent("\(model.id)")
        
        return URLRequest.deleteRequest(withUrl: url)
    }
}
