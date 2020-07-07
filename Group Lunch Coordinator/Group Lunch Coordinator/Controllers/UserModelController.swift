//
//  UserModelController.swift
//  Group Lunch Coordinator
//
//  Created by B$hady on 6/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class UserModelController {
    

        //MARK: -Variables and Constants
        
    let usersBool : Bool = UserDefaults.standard.bool(forKey: .usersInitializedKey)
        
        
    var users : [User] = [User(name: "John", userGroups: [UserGroup(group: Group(name: "Christians"), locations: [])]), User(name: "Jesus", userGroups: [UserGroup(group: Group(name: "Christians"), locations: [])]), User(name: "Dave", userGroups: [UserGroup(group: Group(name: "Christians"), locations: [])])]
        
        
        var usersURL : URL? {
            let fm = FileManager.default
            guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
            return dir.appendingPathComponent("LunchUsers.plist")
        }
        
        //MARK: - Initializer
        
        init() {
            if usersBool == false {
                createInitialUsers()
                UserDefaults.standard.set(true, forKey: .usersInitializedKey)
                print("created users \(usersBool)")
            } else {
                //loadFromPersistenceStore()
                print("loaded users \(usersBool)")
            }
        }
        
        
        //MARK: -Persistence Functions
        
        func createInitialUsers() {
            saveToPersistenceStore()
        }
        
        
        func saveToPersistenceStore() {
            guard let url = usersURL else {return}
            do {
            let encoder = PropertyListEncoder()
                let data = try encoder.encode(users)
            try data.write(to: url)
                
            } catch  {
                print("Not able to encode the data")
            }
        }
    
        
        func loadFromPersistenceStore() {
            let fm = FileManager.default
            guard let url = usersURL, fm.fileExists(atPath: url.path) else {return}
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = PropertyListDecoder()
                    users = try decoder.decode([User].self, from: data)
                    
                } catch {
                    print("Not able to decode the data")
                }
            
        }
    
    
    func calculateTotalMembers(groupName: String) -> Int {
        var totalMembers = 0
        for user in users {
                for userGroup in user.userGroups {
                if userGroup.group.name == groupName {
                    totalMembers += 1
                }
                
            }
        }
       return totalMembers
    }
         
    
    func membersInGroup(groupName: String) -> [String] {
        var membersArray = [String]()
        for user in users {
            for userGroup in user.userGroups {
                    if userGroup.group.name == groupName {
                        membersArray.append(user.name)
                    }
                }

        }
        return membersArray

    }
    
    func addGroupToCurrentUser(currentUser: User, group: Group) {
        
        users.removeLast()
        
        var newUser = User(name: currentUser.name, userGroups: currentUser.userGroups)
        newUser.userGroups.append(UserGroup(group: group))
        users.append(newUser)
        saveToPersistenceStore()
        
    }
    
    func removeGroupFromCurrentUser(currentUser: User, group: Group) {
        
        users.removeLast()
        
        var newUserGroupArray : [UserGroup] = []
        
        for userGroup in currentUser.userGroups {
            if userGroup.group.name != group.name {
                newUserGroupArray.append(userGroup)
            }
        }
        
        let newUser = User(name: currentUser.name, userGroups: newUserGroupArray)
        users.append(newUser)
        saveToPersistenceStore()
        
    }
  }

        //MARK: -Extension of String Class for Key in User Defaults

    extension String {
        static let usersInitializedKey = "usersInitializedKey"
        
    }

    

