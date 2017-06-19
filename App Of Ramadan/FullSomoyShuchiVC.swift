//
//  FullSomoyShuchiVC.swift
//  App Of Ramadan
//
//  Created by Md AfzaL Hossain on 5/29/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit

class FullSomoyShuchiVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var engDates = [String]()
    let sehriTimes = ["3:41","3:40","3:40","3:40","3:39","3:39","3:39","3:39","3:39","3:39","3:38","3:38","3:38","3:38","3:38","3:38","3:38","3:37","3:38","3:38","3:38","3:38","3:38","3:38","3:38","3:38","3:39","3:39","3:39","3:39"]
    let ifterTimes = ["6:43","6:44","6:44","6:45","6:45","6:46","6:46","6:46","6:47","6:47","6:47","6:48","6:48","6:49","6:49","6:50","6:50","6:50","6:50","6:51","6:51","6:51","6:51","6:52","6:52","6:52","6:52","6:53","6:53","6:53"]
    
    let zillaNames = ["Dhaka","Barisal","Chittagong","Khulna","Rajshahi","Rangpur", "Sylhet","Barguna","Bhola","Jhalokati","Patuakhali","Pirojpur","Bandarban", "Bramanbaria","Chadpur","Comilla","Cox's bazar","Feni","Khagrachhari","Lakshmipur","Noakhali","Rangamati","Faridpur","Gazipur","Gopalganj","Jamalpur","Kishoregonj","Madaripur","Manikganj","Mymensingh","Munshiganj","Narayanganj","Narsingdi","Netrakona","Rajbari","Shariatpur","Sherpur","Tangail","Bagerhat","Chuadanga","Jessore","Jhenaidah","Kushtia","Magura","Meherpur","Narail","Satkhira","Bogra","Chapainababganj","Joypurhat","Pabna","Naogan","Natore","Sirajganj","Dinajpur","Gaibandha","Lalmonirhat","Nilphamari","Panchagarh","Ranpur","Thakurgaon","Habiganj","Maulvibazar","Sunamganj","Kurigram"].sorted()
    
    var chosenZillaName = ""
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var zillaNameLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        engDates.append("28/05/2017")
        engDates.append("29/05/2017")
        engDates.append("30/05/2017")
        engDates.append("31/05/2017")
        for i in 1...26 {
            engDates.append("\(i)/06/2017")
        }
        
        pickerView.alpha = 0
        
        uiView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(FullSomoyShuchiVC.zillaSelect))
        uiView.addGestureRecognizer(gesture)
        
        let zillaObj = UserDefaults.standard.object(forKey: "zilla")
        if let zillaName = zillaObj as? String {
            chosenZillaName = zillaName
            zillaNameLbl.text = zillaName
            tableView.reloadData()
        }
        
    }
    
    
    func zillaSelect() {
        pickerView.alpha = 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FullMonthCell {
            cell.ramadanDateLbl.text = String(indexPath.row + 1)
            cell.engDateLbl.text = engDates[indexPath.row]
            let model = IfterSehriModel()
            model.plusMinusSehriTime(zillaName: chosenZillaName, sehriTime: sehriTimes[indexPath.row])
            model.plusMinusIfterTime(zillaName: chosenZillaName, ifterTime: ifterTimes[indexPath.row])
            cell.sehriLbl.text = model.exactSehriTime
            cell.ifterLbl.text = model.exactIfterTime
            return cell
        }else {
            return UITableViewCell()
        }
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
        let zillaName = zillaNames[row]
        self.zillaNameLbl.text = zillaName
        UserDefaults.standard.set(zillaName, forKey: "zilla")
        pickerView.alpha = 0
        viewDidLoad()
    }


}
