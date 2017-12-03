//
//  RequestManager.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class RequestManager {
    
    let networkManager = NetworkManager()
    static let shared = RequestManager()
    
    func load<T: Model>(page: Int, limit: Int, completion: @escaping (_ success: Bool, _ stations: Results<T>?, _ error: Error?) -> ()) {
        let request = Requests<T>.get(page: page, limit: limit)
        perform(request: request, withResponseType: Results<T>.self, completion: completion)
    }
    
    func create<T: Model>(_ model: T, completion: @escaping (_ success: Bool, _ stations: T?, _ error: Error?) -> ()) {
        let request = Requests<T>.create(model)
        print(try! JSONSerialization.jsonObject(with: request.httpBody!, options: []))
        perform(request: request, withResponseType: T.self, completion: completion)
    }
    
    func update<T: Model>(_ model: T, completion: @escaping (_ success: Bool, _ error: Error?) -> ()) {
        let request = Requests<T>.update(model)
        perform(request: request, completion: completion)
    }
    
    func delete<T: Model>(_ model: T, completion: @escaping (_ success: Bool, _ error: Error?) -> ()) {
        let request = Requests<T>.delete(model)
        perform(request: request, completion: completion)
    }
    
    func login(username: String, password: String, completion: @escaping (_ success: Bool, _ token: User?, _ error: Error?) -> ()) {
        let request = LoginRequests.login(username: username, password: password)
        perform(request: request, withResponseType: User.self, completion: completion)
    }
}

//MARK: - Private
private extension RequestManager {
    
    func perform(request: URLRequest, completion: @escaping (_ success: Bool, _ data: Any?, _ error: Error?) -> Void) {
        #if LOG_REQUESTS
            print(request)
            
            if let body = request.httpBody {
                print(try! JSONSerialization.jsonObject(with: body, options: []))
            }
        #endif
        networkManager.perform(request: request) { success, data, error in
            var object: Any? = nil
            if let data = data {
                object = try? JSONSerialization.jsonObject(with: data, options: [])
            }
            DispatchQueue.main.async {
                completion(success, object, error)
            }
        }
    }
    
    func perform(request: URLRequest, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        perform(request: request) { (success, _, error) in
            completion(success, error)
        }
    }
    
    func perform<T: Decodable>(request: URLRequest, withResponseType responseType: T.Type?, completion: @escaping (_ success: Bool, _ data: T?, _ error: Error?) -> Void) {
        #if LOG_REQUESTS
            print(request)
            
            if let body = request.httpBody {
                print(try! JSONSerialization.jsonObject(with: body, options: []))
            }
        #endif
        networkManager.perform(request: request) { success, data, error in
            if success, let data = data {
                self.processSuccess(data, responseType: responseType, error: error, completion: completion)
            } else {
                completion(false, nil, error)
            }
        }
    }
    
    func processSuccess<T: Decodable>(_ data: Data, responseType: T.Type?, error: Error?, completion: @escaping (_ success: Bool, _ data: T?, _ error: Error?) -> Void) {
        var resultObject: T? = nil
        var success = true
        var error: Error? = nil
        defer {
            DispatchQueue.main.async {
                completion(success, resultObject, error)
            }
        }
        
        if let responseType = responseType {
            do {
                resultObject = try JSONDecoder().decode(responseType, from: data)
            } catch let parseError {
                success = false
                error = parseError
            }
        }
    }
}
