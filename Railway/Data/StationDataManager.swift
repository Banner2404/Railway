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
    
    func create(_ object: Model, completion: @escaping (Bool, Model?, Error?) -> Void) {
        guard let object = object as? Station else {
                fatalError("incorrect object type")
        }
        create(station: object, completion: completion)
    }
    
    func update(_ object: Model, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        guard let object = object as? Station else {
            fatalError("incorrect object type")
        }
        update(station: object, completion: completion)
    }
    
    func delete(_ object: Model, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        guard let object = object as? Station else {
            fatalError("incorrect object type")
        }
        delete(station: object, completion: completion)
    }

    func create(station: Station, completion: @escaping (Bool, Station?, Error?) -> Void) {
        RequestManager.shared.create(station, completion: completion)
    }
    
    func update(station: Station, completion: @escaping (Bool, Error?) -> Void) {
        RequestManager.shared.update(station, completion: completion)
    }
    
    func delete(station: Station, completion: @escaping (Bool, Error?) -> Void) {
        RequestManager.shared.delete(station, completion: completion)
    }
}
