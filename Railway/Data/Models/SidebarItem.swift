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
    let section: Section
 
    init(title: String, image: NSImage, section: Section) {
        self.title = title
        self.image = image
        self.section = section
    }
    
    static var defaultItems: [SidebarItem] {
        return [
            //SidebarItem(title: "Tickets", image: #imageLiteral(resourceName: "testIcon"), section: .tickets),
            SidebarItem(title: "Stations", image: #imageLiteral(resourceName: "testIcon"), section: .stations),
            SidebarItem(title: "Accounts", image: #imageLiteral(resourceName: "testIcon"), section: .accounts),
            SidebarItem(title: "Passengers", image: #imageLiteral(resourceName: "testIcon"), section: .passengers),
            SidebarItem(title: "Routes", image: #imageLiteral(resourceName: "testIcon"), section: .routes),
            SidebarItem(title: "Logs", image: #imageLiteral(resourceName: "testIcon"), section: .logs),
//            SidebarItem(title: "Trains", image: #imageLiteral(resourceName: "testIcon"), section: .trains),
//            SidebarItem(title: "Passengers", image: #imageLiteral(resourceName: "testIcon"), section: .passengers),
//            SidebarItem(title: "Users", image: #imageLiteral(resourceName: "testIcon"), section: .users),
        ]
    }
    
    enum Section {
        case stations
        case accounts
        case passengers
        case routes
        case logs

        //        case tickets
        //        case trains
    }
}

class ClassMap {
    
    static func editViewController(for selectedType: SidebarItem.Section) -> BaseViewController.Type {
        return classes(for: selectedType).controller
    }
    
    static func model(for selectedType: SidebarItem.Section) -> Model.Type {
        return classes(for: selectedType).model
    }
    
    static func dataManager(for selectedType: SidebarItem.Section) -> DataManager.Type {
        return classes(for: selectedType).dataManager
    }
    
    static func classes(for selectedType: SidebarItem.Section) -> (controller: BaseViewController.Type, model: Model.Type, dataManager: DataManager.Type) {
        switch selectedType {
        case .stations:
            return (EditStationViewController.self, Station.self, DefaultDataManager<Station>.self)
        case .accounts:
            return (EditAccountViewController.self, Account.self, DefaultDataManager<Account>.self)
        case .passengers:
            return (EditPassengerViewController.self, Passenger.self, DefaultDataManager<Passenger>.self)
        case .routes:
            return (EditRouteViewController.self, Route.self, DefaultDataManager<Route>.self)
        case .logs:
            return (EditLogViewController.self, LogRecord.self, DefaultDataManager<LogRecord>.self)
        }
    }
}



