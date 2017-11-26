//
//  NetworkManager.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class NetworkManager {
    
    func perform(request: URLRequest, completion: @escaping (_ success: Bool, _ data: Data?, _ error: Error?) -> Void) {
        let session = URLSession.shared
        print(request)
        session.dataTask(with: request) { data, response, error in
            var success = false
            var resultData: Data? = data
            var error = error
            defer {
                completion(success, resultData, error)
            }
            print()
            if error != nil {
                return
            }
            
            if data != nil {
                success = true
                print((try? JSONSerialization.jsonObject(with: data!, options: [])) ?? "no responce")
            }
        }.resume()
    }
}
