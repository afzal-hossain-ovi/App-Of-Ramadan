//
//  SittingVC.swift
//  App Of Ramadan
//
//  Created by Md AfzaL Hossain on 5/25/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit
import UserNotifications

class SittingsVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var zillaSelection: UIStackView!
    @IBOutlet weak var zillaNameLbl: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var timePicker: UIDatePicker!
    var notifyTime = ""
    var chosenZillaName = ""
    let dateFormatter = DateFormatter()
    
    let zillaNames = ["Dhaka","Barisal","Chittagong","Khulna","Rajshahi","Rangpur", "Sylhet","Barguna","Bhola","Jhalokati","Patuakhali","Pirojpur","Bandarban", "Bramanbaria","Chadpur","Comilla","Cox'sbazar","Feni","Khagrachhari","Lakshmipur","Noakhali","Rangamati","Faridpur","Gazipur","Gopalganj","Jamalpur","Kishoregonj","Madaripur","Manikganj","Mymensingh","Munshiganj","Narayanganj","Narsingdi","Netrakona","Rajbari","Shariatpur","Sherpur","Tangail","Bagerhat","Chuadanga","Jessore","Jhenaidah","Kushtia","Magura","Meherpur","Narail","Satkhira","Bogra","Chapainababganj","Joypurhat","Pabna","Naogan","Natore","Sirajganj","Dinajpur","Gaibandha","Lalmonirhat","Nilphamari","Panchagarh","Ranpur","Thakurgaon","Habiganj","Maulvibazar","Sunamganj","Kurigram"].sorted()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        zillaSelection.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(SittingsVC.zillaSelect))
        zillaSelection.addGestureRecognizer(gesture)
        pickerView.alpha = 0
        
        timeView.isUserInteractionEnabled = true
        let gestureR = UITapGestureRecognizer(target: self, action: #selector(SittingsVC.timeSelect))
        timeView.addGestureRecognizer(gestureR)
        timePicker.alpha = 0
        
        
        
        let timeObj = UserDefaults.standard.object(forKey: "time")
        if let time = timeObj as? String {
            notifyTime = time
            timeLbl.text = notifyTime
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (didAllow, error) in
            
        }
        
        
        
        
        let zillaObj = UserDefaults.standard.object(forKey: "zillaName")
        if let zillaName = zillaObj as? String {
                zillaNameLbl.text = zillaName
        }
        
    }
    
    func zillaSelect() {
       pickerView.alpha = 1
    }
    
    func timeSelect() {
        timePicker.alpha = 1
    }
    
    @IBAction func notifyAction(sender: Any) {
        
        let content = UNMutableNotificationContent()
        content.title = "Al-Hadith"
        content.body = "this use for hadith"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "TimerDone", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        print("afzal")
    }
    
    @IBAction func timeValueChanged(_ sender: Any) {
        dateFormatter.dateFormat = "hh:mm a"
        notifyTime = dateFormatter.string(from: timePicker.date)
        timeLbl.text = notifyTime
        UserDefaults.standard.set(notifyTime, forKey: "time")
        timePicker.alpha = 0
        
        
    }


    @IBAction func back(_ sender: Any) {
       // dismiss(animated: true, completion: nil)
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return zillaNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return zillaNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenZillaName = zillaNames[row]
        zillaNameLbl.text = chosenZillaName
        UserDefaults.standard.set(chosenZillaName, forKey: "zillaName")
        pickerView.alpha = 0
    }
}
