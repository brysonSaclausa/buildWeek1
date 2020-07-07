//
//  LocationTableViewCell.swift
//  Group Lunch Coordinator
//
//  Created by B$hady on 6/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit



class LocationTableViewCell: UITableViewCell {

    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var voteButton: UIButton!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    

    
    var locations: [Location] = []
    var location: Location? {
        didSet {
            updateViews()
        }
    }
    
    let locationController = LocationController()
    
  
    
    @IBAction func voteButtonTapped(_ sender: Any) {
        location?.rank += 1
        rankLabel.text = "\(location?.rank ?? 1)"
        //locations.sort(by: { $0.rank > $1.rank })
        
        
     }
    

    
    
    private func updateViews() {
        guard let location = location else { return }
        locationNameLabel.text = location.name
        timeLabel.text = location.time
        
    }
}
