//
//  StationDataManager.swift
//  Railway
//
//  Created by Соболь Евгений on 10/27/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

class StationDataManager: DataManager {
    
    required init() {}
    
    func create(_ object: Any, completion: @escaping (Bool, Any?, Error?) -> Void) {
        guard let object = object as? Station else {
                fatalError("incorrect object type")
        }
        create(station: object, completion: completion)
    }
    
    func create(station: Station, completion: @escaping (Bool, Station?, Error?) -> Void) {
        RequestManager.shared.create(station, completion: completion)
    }
}
