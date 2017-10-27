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
    func update(_ object: Model, completion: @escaping (_ success: Bool, _ object: Model?, _ error: Error?) -> Void)
}
