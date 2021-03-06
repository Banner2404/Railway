//
//  AddItemTypeViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 10/25/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class AddItemTypeViewController: NSViewController, BaseViewController {
    
    let TypeCollectionViewItemIdentifier = NSUserInterfaceItemIdentifier(rawValue: "TypeCollectionViewItem")
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet var arrayController: NSArrayController!
    var selectedType: SidebarItem.Section {
        let selectedIndex = collectionView.selectionIndexes.first!
        let sections = arrayController.content as! [SidebarItem]
        return sections[selectedIndex].section
    }
    
    class func loadFromStoryboard() -> Self {
        return loadFromAdminStoryboard()
    }
    
    override func viewDidLoad() {
        collectionView.register(TypeCollectionViewItem.self, forItemWithIdentifier: TypeCollectionViewItemIdentifier)
        setupArrayController()
        super.viewDidLoad()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
}

//MARK: - Private
private extension AddItemTypeViewController {
    
    func setupArrayController() {
        arrayController.content = SidebarItem.defaultEditableItems
    }
}
