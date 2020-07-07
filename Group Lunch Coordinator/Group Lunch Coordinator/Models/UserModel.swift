//
//  UserModel.swift
//  Group Lunch Coordinator
//
//  Created by B$hady on 6/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import UIKit

struct User: Codable, Equatable {
    
    var name: String
    var userGroups : [UserGroup] = []
    
    init(name: String, userGroups: [UserGroup]) {
        self.name = name
        self.userGroups = userGroups
    }
}

struct UserGroup: Codable, Equatable {
    var group : Group
    var locations : [Location] = []
}

struct TimeFrameGroup {
    var users: [User] = []
    
}

struct Location: Codable, Equatable {
    let name: String
    var rank: Int = 1
    var vote: Bool?
    var time: String?
}

struct Time {
    let times: [String]
}
