//
//  SidebarItem.swift
//  Railway
//
//  Created by Соболь Евгений on 10/23/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class SidebarItem: NSObject {
    
    @objc
    let title: String
    @objc
    let image: NSImage
 
    init(title: String, image: NSImage) {
        self.title = title
        self.image = image
    }
    
    static var defaultItems: [SidebarItem] {
        return [
            SidebarItem(title: "Tickets", image: #imageLiteral(resourceName: "testIcon")),
            SidebarItem(title: "Stations", image: #imageLiteral(resourceName: "testIcon")),
            SidebarItem(title: "Trains", image: #imageLiteral(resourceName: "testIcon")),
            SidebarItem(title: "Passengers", image: #imageLiteral(resourceName: "testIcon")),
            SidebarItem(title: "Users", image: #imageLiteral(resourceName: "testIcon")),
            SidebarItem(title: "Logs", image: #imageLiteral(resourceName: "testIcon")),
            SidebarItem(title: "Routes", image: #imageLiteral(resourceName: "testIcon")),
        ]
    }
}
