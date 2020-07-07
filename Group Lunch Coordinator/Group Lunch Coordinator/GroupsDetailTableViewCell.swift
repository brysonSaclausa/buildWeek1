//
//  GroupsDetailTableViewCell.swift
//  Group Lunch Coordinator
//
//  Created by John McCants on 7/5/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class GroupsDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    var member : String? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateViews() {
        
        guard let member = member else {return}
        nameLabel.text = member
        
    }

}
