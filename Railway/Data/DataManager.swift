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
    func details(_ object: Model, token: String, completion: @escaping (_ success: Bool, _ object: Model?, _ error: Error?) -> Void)
    func create(_ object: Model, token: String, completion: @escaping (_ success: Bool, _ object: Model?, _ error: Error?) -> Void)
    func update(_ object: Model, token: String, completion: @escaping (_ success: Bool, _ error: Error?) -> Void)
    func delete(_ object: Model, token: String, completion: @escaping (_ success: Bool, _ error: Error?) -> Void)
}

class DefaultDataManager<T: Model>: DataManager {
    
    required init() {}
    
    func details(_ object: Model, token: String, completion: @escaping (_ success: Bool, _ object: Model?, _ error: Error?) -> Void) {
        guard let object = object as? T else {
            fatalError("incorrect object type")
        }
        details(object: object, token: token, completion: completion)
    }
    
    func create(_ object: Model, token: String, completion: @escaping (Bool, Model?, Error?) -> Void) {
        guard let object = object as? T else {
            fatalError("incorrect object type")
        }
        create(object: object, token: token, completion: completion)
    }
    
    func update(_ object: Model, token: String, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        guard let object = object as? T else {
            fatalError("incorrect object type")
        }
        update(object: object, token: token, completion: completion)
    }
    
    func delete(_ object: Model, token: String, completion: @escaping (_ success: Bool, _ error: Error?) -> Void) {
        guard let object = object as? T else {
            fatalError("incorrect object type")
        }
        delete(object: object, token: token, completion: completion)
    }
    
    func details(object: T, token: String, completion: @escaping (Bool, T?, Error?) -> Void) {
            RequestManager.shared.load(id: object.id, token: token, completion: { (success: Bool, result: Result<T>?, error: Error?) in
                completion(success, result?.data, error)
            })
    }
    
    func create(object: T, token: String, completion: @escaping (Bool, T?, Error?) -> Void) {
        RequestManager.shared.create(object, token: token, completion: completion)
    }
    
    func update(object: T, token: String, completion: @escaping (Bool, Error?) -> Void) {
        RequestManager.shared.update(object, token: token, completion: completion)
    }
    
    func delete(object: T, token: String, completion: @escaping (Bool, Error?) -> Void) {
        RequestManager.shared.delete(object, token: token, completion: completion)
    }
}
