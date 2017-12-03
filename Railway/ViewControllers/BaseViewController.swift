//
//  BaseViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

protocol BaseViewController {
    
    var requestManager: RequestManager { get }
    var userAccountManager: UserAccountManager { get }

    static func loadFromAdminStoryboard<T>() -> T
}

extension BaseViewController {
    
    var requestManager: RequestManager {
        return RequestManager.shared
    }
    
    var userAccountManager: UserAccountManager {
        return UserAccountManager.shared
    }

    static func loadFromAdminStoryboard<T>() -> T {
        return loadFromStoryboard(name: "Admin")
    }
    
    static func loadFromStoryboard<T>(name: String) -> T {
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: name), bundle: nil)
        let controllerName = String(describing: self)
        return storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: controllerName)) as! T
    }

}
