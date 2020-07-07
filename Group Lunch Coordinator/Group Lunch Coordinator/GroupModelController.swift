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
    
    
    var groups = [Group(name: "Google Sales People")]
    
    
    var groupsURL : URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return dir.appendingPathComponent("LunchGroups.plist")
    }
    
    //MARK: - Initializer
    
    init() {
        if groupsBool == false {
            createInitialGroups()
            UserDefaults.standard.set(true, forKey: .groupsInitializedKey)
            print("created \(groupsBool)")
        } else {
            //loadFromPersistenceStore()
            print("loaded \(groupsBool)")
        }
    }
    
    
    //MARK: -Persistence Functions
    
    func createInitialGroups() {
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
