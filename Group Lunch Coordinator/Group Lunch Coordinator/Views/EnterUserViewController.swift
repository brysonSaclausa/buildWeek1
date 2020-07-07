//
//  EnterUserViewController.swift
//  Group Lunch Coordinator
//
//  Created by John McCants on 7/5/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class EnterUserViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    var currentUser : User?
    var userController = UserModelController()

    override func viewDidLoad() {
        super.viewDidLoad()
        userController.loadFromPersistenceStore()
        welcomeNotification()
    }
    
    @IBAction func joinButtonTapped(_ sender: UIButton) {
        
        if nameTextField.text?.isEmpty == true {
            showAlert()
        } else {
        
        guard let unwrappedName = nameTextField.text, !unwrappedName.isEmpty else {return}
        
        let newUser = User(name: unwrappedName, userGroups: [])
        userController.users.append(newUser)
        userController.saveToPersistenceStore()
        currentUser = newUser
        
        }
    }
    
    func welcomeNotification() {
        let alert = UIAlertController(title: "Welcome to Group Lunch App!", message: "An tool made for anyone that has a need to coordinate a place and time for lunch with a group!", preferredStyle: .alert)
        let okbutton = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(okbutton)
        self.present(alert, animated: true)
    }
    
    
    func showAlert() {
      
     let alert = UIAlertController(title: "Please enter your name", message: "Can't leave the textfield empty dude or dudet", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
     
    }
    
    func printStatus() {
        for user in userController.users {
            print(user.name)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "join" {
            let destinationVC = segue.destination as? GroupsTableViewController
            destinationVC?.currentUser = currentUser
            destinationVC?.userController = userController
            
            
        }
    }


}
