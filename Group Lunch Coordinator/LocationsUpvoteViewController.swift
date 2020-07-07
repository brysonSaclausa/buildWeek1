//
//  LocationsUpvoteViewController.swift
//  Group Lunch Coordinator
//
//  Created by B$hady on 6/20/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//
import UserNotifications
import UIKit



class LocationsUpvoteViewController: UIViewController {
    
    let locationController = LocationController()
    var userController : UserModelController?
    var currentGroup : Group?
    var locations: [Location] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       tableView.reloadData()
        registerLocal()
        
    }
    
    
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let locations = segue.destination as? AddLocationViewController else { return }
        
        locations.locationController = locationController
     }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        getNotificationActionSheet()
    }
    
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted,
            error in
            if granted {
                print("granted")
            } else {
                print("not granted")
            }
        }
    }
    
    @objc func scheduleLunch() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        guard let userController = userController, let currentUser = userController.users.last, let currentGroup = currentGroup else {return}
        
        let content = UNMutableNotificationContent()
        content.title = "\(currentUser.name), its time to head to lunch!"
        content.body = "See you at Location, with the \(currentGroup.name)!"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 6, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    
    
    
    func getNotificationActionSheet() {
        
         guard let userController = userController, let currentUser = userController.users.last else {return}
        let actionSheet = UIAlertController(title:"Confirmed!", message:"Would you like a reminder for when to leave for lunch? ", preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let yes = UIAlertAction(title: "Yes", style: .default) { action in
            let alert = UIAlertController(title: "Thanks \(currentUser.name)!", message: "You will be notified when its time to leave for lunch!", preferredStyle: .alert)
            let okbutton = UIAlertAction(title: "OK", style: .cancel) {action in
                self.registerLocal()
                self.scheduleLunch()
              
            }
            
            alert.addAction(okbutton)
            
            self.present(alert, animated: true)
            
        }
        
        let no = UIAlertAction(title: "No", style: .default) { action in
            let alert = UIAlertController(title: "Thanks User Name!", message: "See you at LocationName, with the GroupName", preferredStyle: .alert)
            let okbutton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okbutton)
            self.present(alert, animated: true)
            
        }
        
        actionSheet.addAction(cancel)
        actionSheet.addAction(yes)
        actionSheet.addAction(no)
        present(actionSheet, animated: true)
    }
    
    
    func setUpUserController() {
        guard let userController = userController, let currentUser = userController.users.last else {return}
    }
    
    

}




extension LocationsUpvoteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationController.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath) as? LocationTableViewCell else { return UITableViewCell() }
        
        let location = locationController.locations[indexPath.row]
        
        cell.location = location
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection: String, section: Int) -> String? {
       return "Vote for location"
    }
}
