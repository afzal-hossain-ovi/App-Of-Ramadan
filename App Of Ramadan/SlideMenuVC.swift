//
//  SlideMenuVC.swift
//  App Of Ramadan
//
//  Created by Md AfzaL Hossain on 5/28/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit

class SlideMenuVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var titleNames = ["App Of Ramadan","পুর্নাঙ্গ সুচী","অডিও কোরআন","কোরআন ও হাদীস","তাসবীহ","আর্টিকেল ও মাসআলা","প্রয়োজনীয় দোয়া","রমজানের খাদ্যভ্যাস"]
    var row = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SlideMenuCell {
            cell.slideTitleLbl.text = titleNames[indexPath.row]
            cell.slideImg.image = UIImage(named: "icon\(indexPath.row + 1)")
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        row = indexPath.row + 1
        switch row {
        case 1:
            performSegue(withIdentifier: "toMainVC", sender: nil)
            break
        case 2:
            performSegue(withIdentifier: "toFullSomoyShuchiVC", sender: nil)
            break
        case 3:
            performSegue(withIdentifier: "toOdioQuranVC", sender: nil)
            break
        case 4:
            performSegue(withIdentifier: "toQuranHadithMasalahDoaVC", sender: row)
            break
        case 5:
            performSegue(withIdentifier: "toTasbihVC", sender: nil)
            break
        case 6,7,8:
            performSegue(withIdentifier: "toQuranHadithMasalahDoaVC", sender: row)
            break
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuranHadithMasalahDoaVC" {
            let navBar = segue.destination as? UINavigationController
            let quranHadithVC = navBar?.topViewController as! QuranHadithMasalahDoaVC
            quranHadithVC.row = row
        }
    }

}
