//
//  OdioQuranVC.swift
//  App Of Ramadan
//
//  Created by Md AfzaL Hossain on 5/28/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit
import AVFoundation

class OdioQuranVC: UIViewController,UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate {
    
    var names = [String]()
    var player = AVPlayer()
    var isPalying = true
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var suraNameLbl: UILabel!
    @IBOutlet weak var qariNameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let csvPath = Bundle.main.path(forResource: "allsurah", ofType: "csv")
        do {
            let csvFile = try CSV(contentsOfURL: csvPath!)
            let rows = csvFile.rows
            for row in rows {
                let name = row["name"]
                names.append(name!)
            }
        }catch {
            print(error.localizedDescription)
        }
        
        playerView.alpha = 0
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SurahNameCell {
            cell.surahNamesLbl.text = names[indexPath.row]
            return cell
        }else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let id = indexPath.row + 1
        suraNameLbl.text = "সূরা:\(names[indexPath.row])"
        qariNameLbl.text = "ক্কারীঃ মিশরি আলাফাসি"
         let url = URL(string: "http://api.alquran.cloud/surah/\(id)/ar.alafasy")
         let dataTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("error")
            }else {
                if let jsonData = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        let data = jsonResult["data"] as AnyObject
                        let ayahs = data["ayahs"] as! NSArray
                        for ayah in ayahs  {
                            let audioAyah = ayah as! NSDictionary
                            if let audioPath = audioAyah["audio"] as? String {
                                let url = URL(string: audioPath)
                                let playerItem = AVPlayerItem(url: url!)
                                
                                    self.player = AVPlayer(playerItem: playerItem)
                                    self.player.play()
                                    
                            }
                            
                        }
                        
                    }catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        dataTask.resume()
        
        playerView.alpha = 1
        playBtn.setImage(UIImage(named: "pause.png"), for: .normal)
        
    }
    
    
    @IBAction func playpause(_ sender: Any) {
        if isPalying {
            player.pause()
            playBtn.setImage(UIImage(named: "play.png"), for: .normal)
        }else {
            player.play()
            playBtn.setImage(UIImage(named: "pause.png"), for: .normal)
        }
        
        isPalying = !isPalying
    }
    
    @IBAction func stop(_ sender: Any) {
        player.pause()
        playBtn.setImage(UIImage(named: "play.png"), for: .normal)
        isPalying = false
    }
    


}
