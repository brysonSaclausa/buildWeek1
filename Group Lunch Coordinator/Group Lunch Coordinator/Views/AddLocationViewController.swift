//
//  VoteForLocationViewController.swift
//  Group Lunch Coordinator
//
//  Created by B$hady on 6/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

protocol TimePickerDelegate {
    func timeWasChosen(_ time: String)
}
class AddLocationViewController: UIViewController {
    
    var locationController: LocationController?
    
    var selectedTime: String?

    var delegate = TimePickerDelegate.self
    
    
    @IBOutlet weak var enterLocationTextField: UITextField!
    @IBOutlet weak var timePickerView: UIPickerView!
    
     let ltbc = LocationTableViewCell()
    
     let timeData = ["11:00 AM", "12:00 PM", "1:00 PM"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addLocationTappedButton(_ sender: Any) {
        guard let locationName = enterLocationTextField.text, !locationName.isEmpty, let selectedTime = selectedTime else { return }
        
        locationController?.createLocation(with: locationName, time: selectedTime)
      
        
        self.navigationController?.popViewController(animated: true)
        
        
    }
    
    
}

extension AddLocationViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        timeData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        timeData[row]
    }
  
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTime = timeData[row]
        
        
        
        
        
       
    }
}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
