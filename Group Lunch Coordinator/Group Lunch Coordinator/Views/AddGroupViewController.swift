//
//  UserGroupViewController.swift
//  Group Lunch Coordinator
//
//  Created by B$hady on 6/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class AddGroupViewController: UIViewController {
    
    var groupController : GroupController?
    var currentUser : User?
    var userController : UserModelController?

  
    @IBOutlet weak var groupTextField: UITextField!
    
    @IBOutlet weak var addGroupButton: UIButton!
    
    @IBAction func addGroupButtonTapped(_ sender: Any) {
        createGroup()
        dismiss(animated: true) {
            guard let groupController = self.groupController else {return}
            groupController.loadFromPersistenceStore()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    func createGroup() {
         
        guard let groupText = groupTextField.text, groupText.isEmpty == false, let unwrappedUser = currentUser, let group = groupController, let unwrappedUserController = userController else { return }
        
        
        unwrappedUserController.addGroupToCurrentUser(currentUser: unwrappedUser, group: Group(name: groupText))
        
        let newGroup = Group(name: groupText)
        group.groups.append(newGroup)
        group.saveToPersistenceStore()
        _ = navigationController?.popViewController(animated: true)
        
    }

}



