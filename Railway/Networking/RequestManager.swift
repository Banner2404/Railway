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
    
    func loadStations(completion: @escaping (_ success: Bool, _ stations: StationList?, _ error: Error?) -> ()) {
        let request = StationRequests.getStations()
        perform(request: request, withResponseType: StationList.self, completion: completion)
    }
    
    func create(_ station: Station, completion: @escaping (_ success: Bool, _ stations: Station?, _ error: Error?) -> ()) {
        let request = StationRequests.create(station)
        perform(request: request, withResponseType: Station.self, completion: completion)
    }
}

//MARK: - Private
private extension RequestManager {
    
    func perform<T: Decodable>(request: URLRequest, withResponseType responseType: T.Type?, completion: @escaping (_ success: Bool, _ data: T?, _ error: Error?) -> Void) {
        #if LOG_REQUESTS
            print(request)
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
