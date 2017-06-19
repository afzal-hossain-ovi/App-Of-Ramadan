//
//  MainVC.swift
//  App Of Ramadan
//
//  Created by Md AfzaL Hossain on 5/24/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit


class MainVC: UIViewController {

    @IBOutlet weak var engDateLbl: UILabel!
    @IBOutlet weak var hijriDateLbl: UILabel!
    @IBOutlet weak var countryLocationLbl: UILabel!
    @IBOutlet weak var ifteriTimeCountLbl: UILabel!
    @IBOutlet weak var fojorStartLbl: UILabel!
    @IBOutlet weak var fojorEndLbl: UILabel!
    @IBOutlet weak var juhorStartLbl: UILabel!
    @IBOutlet weak var juhorEnd: UILabel!
    @IBOutlet weak var asorStartLbl: UILabel!
    @IBOutlet weak var asorEndLbl: UILabel!
    @IBOutlet weak var magribStartLbl: UILabel!
    @IBOutlet weak var magribEndLbl: UILabel!
    @IBOutlet weak var ishaStartLbl: UILabel!
    @IBOutlet weak var ishaEndLbl: UILabel!
    
    @IBOutlet weak var ifterTimeLbl: UILabel!
    @IBOutlet weak var sehriTimeLBl: UILabel!
    
    var zillaName = ""
    
    var menuVC: SlideMenuVC!
    var isShowMenu = true
    
    var jsonModel: JsonDataModel! = JsonDataModel.instance
    var intarval: TimeInterval = 0
    var timer = Timer()
    let currentDate = Date()
    let formetter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // retrive zilla name
       
        let zillObj = UserDefaults.standard.object(forKey: "zillaName")
        if let zillaname = zillObj as? String {
            zillaName = zillaname
        }
        
        // english date
     
     formetter.dateFormat = "dd MMMM, yyyy"
     let convertDate = formetter.string(from: currentDate)
        engDateLbl.text = convertDate
        
        // hijri date
        let islamicCelender: Calendar = Calendar(identifier: .islamicCivil)
        formetter.calendar = islamicCelender
        let hijriDate = formetter.string(from: currentDate)
        hijriDateLbl.text = hijriDate
        
        
        
        countryLocationLbl.text = zillaName
        jsonModel.jsonDataDownload(zillaName: zillaName){
            self.prayerTime()
            self.timeCount()
        }
        
        // slide menu
        menuVC = self.storyboard?.instantiateViewController(withIdentifier: "SlideMenuVC") as? SlideMenuVC
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(MainVC.respondsToSwipe))
        swipeRight.direction = .right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(MainVC.respondsToSwipe))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
    
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MainVC.runTimer), userInfo: nil, repeats: true)
        
    }
    
    func runTimer() {
        intarval -= 1
        ifteriTimeCountLbl.text = returnTime(time: intarval)
        if intarval == 0 {
            timer.invalidate()
        }
    }
    
    func respondsToSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.right:
            showSlideMenu()
        case UISwipeGestureRecognizerDirection.left:
            closeMenu()
        default:
            break
        }
    }
    
    @IBAction func showMenu() {
        if isShowMenu {
           showSlideMenu()
        }else {
            closeMenu()
        }
        isShowMenu = !isShowMenu
    }
    
    func showSlideMenu() {
        UIView.animate(withDuration: 0.4, animations: {
            self.menuVC.view.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.menuVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.addChildViewController(self.menuVC)
            self.view.addSubview(self.menuVC.view)
        })
    }
    
    func closeMenu() {
        UIView.animate(withDuration: 0.4, animations: {
            self.menuVC.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }, completion: { (finished) in
            self.menuVC.view.removeFromSuperview()
        })
    }
    
    
    
    func prayerTime() {
        
        fojorStartLbl.text = jsonModel.fajorStart
        fojorEndLbl.text = jsonModel.fajorEnd
        juhorStartLbl.text = jsonModel.juhorStart
        juhorEnd.text = jsonModel.juhorEnd
        asorStartLbl.text = jsonModel.asrStart
        asorEndLbl.text = jsonModel.asrEnd
        magribStartLbl.text = jsonModel.magribStart
        magribEndLbl.text = jsonModel.magribEnd
        ishaStartLbl.text = jsonModel.ishaStart
        ishaEndLbl.text = jsonModel.ishaEnd
        sehriTimeLBl.text = jsonModel.sehriEnd
        ifterTimeLbl.text = jsonModel.ifterEnd
    }
    
    func timeCount() {
        let calender = NSCalendar.current
        let hour = calender.component(.hour, from: currentDate)
        let minute = calender.component(.minute, from: currentDate)
        let second = calender.component(.second, from: currentDate)
        let exactTime = "\(hour):\(minute):\(second)"
        let sehriEnd = jsonModel.sehriEnd
        let ifterEnd = jsonModel.ifterEnd
        let ifterEndSeparete = ifterEnd.components(separatedBy: ":")
        let ifterTime = "18:\(ifterEndSeparete[1]):00"
//        let ifterTime = "13:02:00"
        formetter.dateFormat = "HH:mm:ss"
        
        let date1 = formetter.date(from: exactTime)
        let date2 = formetter.date(from: sehriEnd)
        let date3 = formetter.date(from: ifterTime)
        if date3! > date1! {
            intarval = (date3?.timeIntervalSince(date1!))!
        }
        
        
    }
    
    
    func returnTime(time: TimeInterval) ->String {
        let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hour,minute,second)
    }
   
    
}
