//
//  GroupsTableViewController.swift
//  Group Lunch Coordinator
//
//  Created by B$hady on 6/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class GroupsTableViewController: UITableViewController {

    var groupController = GroupController()
    var currentUser : User?
    var userController : UserModelController?
    
    @IBOutlet var groupTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserController()
        setUpNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupUserController()
        groupController.loadFromPersistenceStore()
        self.tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setupUserController()
        groupController.loadFromPersistenceStore()
        self.tableView.reloadData()
    }
    
    func setupUserController() {
        guard let userController = userController, let lastUser = userController.users.last else {return}
        currentUser = lastUser
        userController.loadFromPersistenceStore()
    }
    
    func setUpNavBar() {
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupController.groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Group", for: indexPath) as? GroupsTableViewCell, let unwrappedController = userController else {
            return UITableViewCell()
        }
        let groupName = self.groupController.groups[indexPath.row].name
        cell.group = self.groupController.groups[indexPath.row]
        
        
        let totalMembers = unwrappedController.calculateTotalMembers(groupName: groupName)
        
        cell.totalMembersLabel.text = "\(totalMembers) members"
        

        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Add Group" {
            guard let destinationVC = segue.destination as? AddGroupViewController else {return}
            destinationVC.groupController = self.groupController
            destinationVC.currentUser = currentUser
            destinationVC.userController = userController
            
        } else if segue.identifier == "Detail" {
            guard let destinationVC = segue.destination as? GroupsDetailViewController else {return}
            destinationVC.currentUser = currentUser
            destinationVC.userController = userController
            destinationVC.groupController = groupController
            
            guard let indexPath = groupTableView.indexPathForSelectedRow, let userController = userController else { return }
            let groupName = self.groupController.groups[indexPath.row].name
            
            destinationVC.groupName = groupName
            destinationVC.currentGroup = self.groupController.groups[indexPath.row]
            
            destinationVC.members.append(contentsOf: userController.membersInGroup(groupName: groupName))
            }
    
            
        }
    }



