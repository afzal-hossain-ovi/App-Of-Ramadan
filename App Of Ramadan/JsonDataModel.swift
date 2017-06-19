//
//  JsonDataModel.swift
//  App Of Ramadan
//
//  Created by Md AfzaL Hossain on 5/28/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

typealias DownloadComplete = () -> ()

import Foundation



class JsonDataModel {
    private var _fajorStart: String!
    private var _fajorEnd: String!
    private var _juhorStart: String!
    private var _juhorEnd: String!
    private var _asorStart: String!
    private var _asorEnd: String!
    private var _magribStart: String!
    private var _magribEnd: String!
    private var _ishaStart: String!
    private var _ishaEnd: String!
    private var _sehriEnd: String!
    private var _ifterEnd: String!
    
    static var instance = JsonDataModel()
    
    var url: URL!
    
    var fajorStart: String {
        if _fajorStart == nil {
            _fajorStart = ""
        }
        return _fajorStart
    }
    
    var fajorEnd: String {
        if _fajorEnd == nil {
            _fajorEnd = ""
        }
        return _fajorEnd
    }
    
    var juhorStart: String {
        if _juhorStart == nil {
            _juhorStart = ""
        }
        return _juhorStart
    }
    
    var juhorEnd: String {
        if _juhorEnd == nil {
            _juhorEnd = ""
        }
        return _juhorEnd
    }
    
    var asrStart: String {
        if _asorStart == nil {
            _asorStart = ""
        }
        return _asorStart
    }
    
    var asrEnd: String {
        if _asorEnd == nil {
            _asorEnd = ""
        }
        return _asorEnd
    }
    
    var magribStart: String {
        if _magribStart == nil {
            _magribStart = ""
        }
        return _magribStart
    }
    
    var magribEnd: String {
        if _magribEnd == nil {
            _magribEnd = ""
        }
        return _magribEnd
    }
    
    var ishaStart: String {
        if _ishaStart == nil {
            _ishaStart = ""
        }
        return _ishaStart
    }
    var ishaEnd: String {
        if _magribEnd == nil {
            _magribEnd = ""
        }
        return _ishaEnd
    }
    var sehriEnd: String {
        if _sehriEnd == nil {
            _sehriEnd = ""
        }
        return _sehriEnd
    }
    var ifterEnd: String {
        if _ifterEnd == nil {
            _ifterEnd = ""
        }
        return _ifterEnd
    }
    
    
   
    
    func jsonDataDownload(zillaName: String,completed: @escaping DownloadComplete) {
        
        if zillaName != "" {
             url = URL(string: "http://api.aladhan.com/timingsByCity?city=\(zillaName.lowercased())&country=BD&method=1")
        }else {
            url = URL(string: "http://api.aladhan.com/timingsByCity?city=dhaka&country=BD&method=1")
        }
        let dataTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("error")
            }else {
                if let jsonData = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        let data = jsonResult["data"] as AnyObject
                        let timings = data["timings"] as! Dictionary<String,String>
                        DispatchQueue.main.async(execute: {
                            // start time of salah
                            let fajr = timings["Fajr"]
                            self._fajorStart = fajr
                            let dhuhr = timings["Dhuhr"]
                            self._juhorStart = dhuhr
                            let dateFormetter = DateFormatter()
                            dateFormetter.dateFormat = "HH:mm"
                            let asrDate = dateFormetter.date(from: timings["Asr"]!)
                            let magribDate = dateFormetter.date(from: timings["Maghrib"]!)
                            let ishaDate = dateFormetter.date(from: timings["Isha"]!)
                            dateFormetter.dateFormat = "hh:mm"
                            let asr = dateFormetter.string(from: asrDate!)
                            let magrib = dateFormetter.string(from: magribDate!)
                            let isha = dateFormetter.string(from: ishaDate!)
                            // convert asr from ahle hadith to hanafi
                            let separeteAsr = asr.components(separatedBy: ":")
                            if let hour = Int(separeteAsr[0]) {
                                if let minute = Int(separeteAsr[1]) {
                                    let timeInSecond = ((hour * 60) * 60 + (minute * 60)) + 4680
                                    let timeInEndAsr = ((hour * 60) * 60 + (minute * 60))  + 4680 + 3780
                                    let updateAsr = self.intToMinuteAndHour(second: timeInSecond)
                                    let endAsr = self.intToMinuteAndHour(second: timeInEndAsr)
                                    self._asorStart = updateAsr
                                    self._asorEnd = endAsr
                                }
                            }
                            
                            self._magribStart = magrib
                            self._ishaStart = isha
                            
                            // end time of salah,sehri and ifter
                            let separeteFojor = fajr!.components(separatedBy: ":")
                            if let fajrHour = Int(separeteFojor[0]) {
                                if let fajrMinute = Int(separeteFojor[1]) {
                                    let fajrTimeInSecond = ((fajrHour * 60) * 60 + (fajrMinute * 60)) + 4800
                                    let sehriTimeInSecond = ((fajrHour * 60) * 60 + (fajrMinute * 60)) - 300
                                    let endFajr = self.intToMinuteAndHour(second: fajrTimeInSecond)
                                    let endSehri = self.intToMinuteAndHour(second: sehriTimeInSecond)
                                    self._fajorEnd = endFajr
                                    self._sehriEnd = endSehri
                                }
                            }
                            
                            let separeteDhuhr = dhuhr!.components(separatedBy: ":")
                            if let dhuhrHour = Int(separeteDhuhr[0]) {
                                if let dhuhrMinute = Int(separeteDhuhr[1]) {
                                    let dhuhrTimeInSecond = ((dhuhrHour * 60) * 60 + (dhuhrMinute * 60)) + 14700
                                    let dhuhrTime = self.intToMinuteAndHour(second: dhuhrTimeInSecond)
                                    let dateFormetter = DateFormatter()
                                    dateFormetter.dateFormat = "HH:mm"
                                    let dhuhrDate = dateFormetter.date(from: dhuhrTime)
                                    dateFormetter.dateFormat = "hh:mm"
                                    let endDhuhr = dateFormetter.string(from: dhuhrDate!)
                                    self._juhorEnd = endDhuhr
                                }
                            }
                            
                            
                            let separeteMagrib = magrib.components(separatedBy: ":")
                            if let magribHour = Int(separeteMagrib[0]) {
                                if let magribMinute = Int(separeteMagrib[1]) {
                                    let magribTimeInSecond = ((magribHour * 60) * 60 + (magribMinute * 60)) + 4980
                                    let ifterTimeInSecond = ((magribHour * 60) * 60 + (magribMinute * 60)) + 180
                                    let endMagrib = self.intToMinuteAndHour(second: magribTimeInSecond)
                                    let endIfter = self.intToMinuteAndHour(second: ifterTimeInSecond)
                                    self._magribEnd = endMagrib
                                    self._ifterEnd = endIfter
                                }
                            }
                            
                            let separeteIsha = isha.components(separatedBy: ":")
                            if let ishaHour = Int(separeteIsha[0]) {
                                if let ishaMinute = Int(separeteIsha[1]) {
                                    let ishaTimeInSecond = ((ishaHour * 60) * 60 + (ishaMinute * 60)) + 27960
                                    let ishaTime = self.intToMinuteAndHour(second: ishaTimeInSecond)
                                    let dateFormetter = DateFormatter()
                                    dateFormetter.dateFormat = "HH:mm"
                                    let ishaDate = dateFormetter.date(from: ishaTime)
                                    dateFormetter.dateFormat = "hh:mm"
                                    let endIsha = dateFormetter.string(from: ishaDate!)
                                    self._ishaEnd = endIsha
                                }
                            }
                            
                            completed()
                        })
                        
                    }catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        dataTask.resume()
    }

    func intToMinuteAndHour(second: Int)->String {
        let hour = second / 3600
        let minute = (second / 60) % 60
        return String((hour < 10 ? "0" : "") + String(hour) + ":" + (minute < 10 ? "0":"") + String(minute))
        
    }
    
}
