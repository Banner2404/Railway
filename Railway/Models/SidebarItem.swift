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
}
