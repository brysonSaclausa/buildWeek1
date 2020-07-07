//
//  GroupModel.swift
//  Group Lunch Coordinator
//
//  Created by John McCants on 6/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Group: Codable, Equatable {
    var name : String
    
    
    init(name: String) {
        self.name = name
    }
}
