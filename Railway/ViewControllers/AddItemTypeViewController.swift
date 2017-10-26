//
//  AddItemTypeViewController.swift
//  Railway
//
//  Created by Соболь Евгений on 10/25/17.
//  Copyright © 2017 Insoft. All rights reserved.
//

import Cocoa

class AddItemTypeViewController: NSViewController, BaseViewController, EditChildViewController {
    
    var type = EditViewController.ChildState.create
    var helperMessage = "Select what would you like to add:"
    weak var delegate: EditChildViewControllerDelegate?
    
    let TypeCollectionViewItemIdentifier = NSUserInterfaceItemIdentifier(rawValue: "TypeCollectionViewItem")
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBOutlet var arrayController: NSArrayController!
    
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
        delegate?.setNextButton(enabled: true, sender: self)
    }
    
    func continueButtonClick(completion: @escaping (Any?) -> Void) {
        let sections = arrayController.content as! [SidebarItem]
        completion(sections[collectionView.selectionIndexes.first!].section)
    }
}

//MARK: - Private
private extension AddItemTypeViewController {
    
    func setupArrayController() {
        arrayController.content = SidebarItem.defaultItems 
    }
}
