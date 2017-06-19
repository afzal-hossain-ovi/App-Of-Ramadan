//
//  QuranHadithMasalahDoaCell.swift
//  App Of Ramadan
//
//  Created by Md AfzaL Hossain on 5/30/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit

class QuranHadithMasalahDoaCell: UITableViewCell {

    @IBOutlet weak var dataTitleLbl: UILabel!
    
    func configureCell(model: QuranHadithMasalahModel) {
        dataTitleLbl.text = model.allTitle
    }
    

}
