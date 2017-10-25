//
//  TypeCollectionViewItem.swift
//  Railway
//
//  Created by Соболь Евгений on 10/25/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class TypeCollectionViewItem: NSCollectionViewItem {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.green.cgColor
    }
    
    override var isSelected: Bool {
        didSet {
            view.layer?.backgroundColor = isSelected ? NSColor.red.cgColor : NSColor.green.cgColor
        }
    }
    
}
