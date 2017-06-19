//
//  TasbihVC.swift
//  App Of Ramadan
//
//  Created by Md AfzaL Hossain on 5/28/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit

class TasbihVC: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var tasbihLbl: UILabel!
    var count = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imgView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(TasbihVC.tasbihCount))
        imgView.addGestureRecognizer(gesture)
    }
    
    func tasbihCount() {
        tasbihLbl.text = String(count)
        count += 1
    }

    @IBAction func resetTasbih(_ sender: Any) {
        count = 1
        tasbihLbl.text = "0"
    }

}
