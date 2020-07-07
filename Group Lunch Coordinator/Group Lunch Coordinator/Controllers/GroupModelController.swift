//
//  GroupModelController.swift
//  Group Lunch Coordinator
//
//  Created by John McCants on 6/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation


class GroupController {
    
    //MARK: -Variables and Constants
    
    let groupsBool : Bool = UserDefaults.standard.bool(forKey: .groupsInitializedKey)
    
    
    var groups = [Group(name: "Google Sales People", totalMembers: 200, joined: false), Group(name: "49ers Crew", totalMembers: 19, joined: false), Group(name: "iOS Devs Sacramento", totalMembers: 14, joined: false)]
    
    
    var groupsURL : URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return dir.appendingPathComponent("LunchGroups.plist")
    }
    
    //MARK: - Initializer
    
    init() {
        if groupsBool == false {
            createInitialShoppingItems()
            UserDefaults.standard.set(true, forKey: .groupsInitializedKey)
            print("created \(groupsBool)")
        } else {
            loadFromPersistenceStore()
            print("loaded \(groupsBool)")
        }
    }
    
    
    //MARK: -Persistence Functions
    
    func createInitialShoppingItems() {
        saveToPersistenceStore()
    }
    
    
    func saveToPersistenceStore() {
        guard let url = groupsURL else {return}
        do {
        let encoder = PropertyListEncoder()
        let data = try encoder.encode(groups)
        try data.write(to: url)
            
        } catch  {
            print("Not able to encode the data")
        }
    }
    
    func loadFromPersistenceStore() {
        let fm = FileManager.default
        guard let url = groupsURL, fm.fileExists(atPath: url.path) else {return}
            do {
                let data = try Data(contentsOf: url)
                let decoder = PropertyListDecoder()
                groups = try decoder.decode([Group].self, from: data)
                
            } catch {
                print("Not able to decode the data")
            }
        
    }
    
    
}

    //MARK: -Extension of String Class for Key in User Defaults

extension String {
    static let groupsInitializedKey = "groupsInitializedKey"
    
}
