//
//  QuanHadithMasalahDoaVC.swift
//  App Of Ramadan
//
//  Created by Md AfzaL Hossain on 5/30/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit

class QuranHadithMasalahDoaVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var row = 0
    var ds = QuranHadithMasalahService()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(row)
        ds.quranHadithData()
        ds.masnunDoaData()
        ds.aritcleAndMasalahData()
        ds.foodHabitData()
        let navBar = self.navigationController?.navigationBar
        //navBar?.barStyle = .default
        navBar?.tintColor = UIColor.blue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if row == 4 {
            return ds.quranHadithsModel.count
        }else if row == 6 {
            return ds.articleAndMasalahModel.count
        }else if row == 7 {
            return ds.masnunDoaModel.count
        }else if row == 8 {
            return ds.foodHabitModel.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? QuranHadithMasalahDoaCell {
            if row == 4 {
                cell.configureCell(model: ds.quranHadithsModel[indexPath.row])
            }else if row == 6 {
               cell.configureCell(model: ds.articleAndMasalahModel[indexPath.row])
            }else if row == 7 {
                cell.configureCell(model: ds.masnunDoaModel[indexPath.row])
            }else if row == 8 {
                cell.configureCell(model: ds.foodHabitModel[indexPath.row])
            }
            return cell
            
        }else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if row == 4 {
            performSegue(withIdentifier: "toDetailsVC", sender: ds.quranHadithsModel[indexPath.row])
        }else if row == 6 {
            performSegue(withIdentifier: "toDetailsVC", sender: ds.articleAndMasalahModel[indexPath.row])
        }else if row == 7 {
            performSegue(withIdentifier: "toDetailsVC", sender: ds.masnunDoaModel[indexPath.row])
        }else if row == 8 {
            performSegue(withIdentifier: "toDetailsVC", sender: ds.foodHabitModel[indexPath.row])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            if let detailsVC = segue.destination as? DetailsVC {
                if let model = sender as? QuranHadithMasalahModel {
                    detailsVC.quranModel = model
                }
            }
        }
    }


}
