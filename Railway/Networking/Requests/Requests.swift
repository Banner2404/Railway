//
//  Requests.swift
//  Railway
//
//  Created by Соболь Евгений on 11/26/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class Requests<T: Model> {
    
    static var isUser: Bool {
        return UserAccountManager.shared.user?.type == "USER"
    }
    
    static func get(id: Int, token: String) -> URLRequest {
        var url = URL(string: ApiURL.Host)!
        if isUser {
            url.appendPathComponent(ApiPath.Client)
        }
        url.appendPathComponent(T.apiPath)
        url.appendPathComponent("\(id)")
        
        var request = URLRequest.getRequest(withUrl: url)
        request.addValue(token, forHTTPHeaderField: ApiKey.Authorization)
        return request
    }
    
    static func get(page: Int, limit: Int, token: String, filters: [String: String]?) -> URLRequest {
        var url = URL(string: ApiURL.Host)!
        if isUser {
            url.appendPathComponent(ApiPath.Client)
        }
        url.appendPathComponent(T.apiPath)
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        var queryItems = [
            URLQueryItem(name: ApiPath.Page, value: "\(page)"),
            URLQueryItem(name: ApiPath.Limit, value: "\(limit)"),
        ]
        for (key, value) in filters ?? [:] {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        urlComponents.queryItems = queryItems

        var request = URLRequest.getRequest(withUrl: urlComponents.url!)
        request.addValue(token, forHTTPHeaderField: ApiKey.Authorization)
        return request
    }
    
    static func create(_ model: T, token: String) -> URLRequest {
        var url = URL(string: ApiURL.Host)!
        if isUser {
            url.appendPathComponent(ApiPath.Client)
        }
        url.appendPathComponent(T.apiPath)
        let body = try? JSONEncoder().encode(model)
        var request = URLRequest.postRequest(withUrl: url, body: body)
        request.addValue(token, forHTTPHeaderField: ApiKey.Authorization)
        return request
    }
    
    static func update(_ model: T, token: String) -> URLRequest {
        var url = URL(string: ApiURL.Host)!
        if isUser {
            url.appendPathComponent(ApiPath.Client)
        }
        url.appendPathComponent(T.apiPath)
        url.appendPathComponent("\(model.id)")
        
        let body = try? JSONEncoder().encode(model)
        var request = URLRequest.putRequest(withUrl: url, body: body)
        request.addValue(token, forHTTPHeaderField: ApiKey.Authorization)
        return request
    }
    
    static func delete(_ model: T, token: String) -> URLRequest {
        var url = URL(string: ApiURL.Host)!
        if isUser {
            url.appendPathComponent(ApiPath.Client)
        }
        url.appendPathComponent(T.apiPath)
        url.appendPathComponent("\(model.id)")
        
        var request = URLRequest.deleteRequest(withUrl: url)
        request.addValue(token, forHTTPHeaderField: ApiKey.Authorization)
        return request
    }
}
