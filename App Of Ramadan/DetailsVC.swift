//
//  DetailsVC.swift
//  App Of Ramadan
//
//  Created by Md AfzaL Hossain on 5/31/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var detailsTextView: UITextView!
    
    var quranModel: QuranHadithMasalahModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailsTextView.isEditable = false
        detailsTextView.text = quranModel.allDetails
    }

  

}
