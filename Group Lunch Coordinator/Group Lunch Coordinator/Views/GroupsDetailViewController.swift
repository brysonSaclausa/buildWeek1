//
//  GroupsDetailViewController.swift
//  Group Lunch Coordinator
//
//  Created by John McCants on 7/5/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class GroupsDetailViewController: UIViewController {
    
    var groupController : GroupController?
    var userController : UserModelController?
    var currentUser : User?
    var currentGroup : Group?
    var groupName : String?
    var members : [String] = []
    
    @IBOutlet weak var locationsButton: UIBarButtonItem!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

    }
    
    @IBAction func joinButtonTapped(_ sender: UIButton) {
        print("tapped")
        guard let unwrappedUser = currentUser, let group = currentGroup, let userController = userController else {return}
        print("passed guard")
        if joinButton.titleLabel?.text == "Join Group" {
            userController.addGroupToCurrentUser(currentUser: unwrappedUser, group: group)
            self.tableView.reloadData()
            joinButton.setTitle("Leave Group", for: .normal)
            print("should change to Leave Group")
            self.locationsButton.isEnabled = true
            
        } else if joinButton.titleLabel?.text == "Leave Group" {
            self.tableView.reloadData()
            userController.removeGroupFromCurrentUser(currentUser: unwrappedUser, group: group)
            self.locationsButton.isEnabled = false
        }
        
    }
    
    
    func updateViews() {
        guard let title = groupName else {return}
        self.navigationItem.title = title
        
        guard let userController = userController, let lastUserGroups = userController.users.last else {return}
        
        var checkIfInGroup : Bool? = false
        
        for userGroup in lastUserGroups.userGroups {
                if userGroup.group.name == title {
                    print("the group.name == title")
                    checkIfInGroup = true
                }
            }
        
        guard let unwrappedCheck = checkIfInGroup else {return}
        print(unwrappedCheck)
        if unwrappedCheck == true {
            self.joinButton.setTitle("Leave Group", for: .normal)
            self.locationsButton.isEnabled = true
        } else if unwrappedCheck == false {
        self.joinButton.setTitle("Join Group", for: .normal)
            self.locationsButton.isEnabled = false
    }
    }
 
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "location" {
            guard let destinationVC = segue.destination as? LocationsUpvoteViewController else {return}
            destinationVC.userController = userController
            destinationVC.currentGroup = currentGroup
        }
    
    }
    

    }

extension GroupsDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let unwrappedCell = tableView.dequeueReusableCell(withIdentifier: "detail", for: indexPath) as? GroupsDetailTableViewCell else
        
        {return UITableViewCell()}
        
        unwrappedCell.member = members[indexPath.row]
        
        return unwrappedCell
   
    }
}
