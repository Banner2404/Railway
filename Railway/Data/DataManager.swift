//
//  DataManager.swift
//  Railway
//
//  Created by Соболь Евгений on 10/27/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Foundation

protocol DataManager {
    init()
    func create(_ object: Model, completion: @escaping (_ success: Bool, _ object: Model?, _ error: Error?) -> Void)
    func update(_ object: Model, completion: @escaping (_ success: Bool, _ error: Error?) -> Void)
    func delete(_ object: Model, completion: @escaping (_ success: Bool, _ error: Error?) -> Void)
}

class DefaultDataManager<T: Model>: DataManager {
    
    required init() {}
    
    func create(_ object: Model, completion: @escaping (Bool, Model?, Error?) -> Void) {
        guard let object = object as? T else {
            fatalError("incorrect object type")
        }
        create(object, completion: completion)
    }
    
    func update(_ object: Model, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        guard let object = object as? T else {
            fatalError("incorrect object type")
        }
        update(object, completion: completion)
    }
    
    func delete(_ object: Model, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        guard let object = object as? T else {
            fatalError("incorrect object type")
        }
        delete(object, completion: completion)
    }
    
    func create(_ object: T, completion: @escaping (Bool, T?, Error?) -> Void) {
        RequestManager.shared.create(object, completion: completion)
    }
    
    func update(_ object: T, completion: @escaping (Bool, Error?) -> Void) {
        RequestManager.shared.update(object, completion: completion)
    }
    
    func delete(_ object: T, completion: @escaping (Bool, Error?) -> Void) {
        RequestManager.shared.delete(object, completion: completion)
    }
}
