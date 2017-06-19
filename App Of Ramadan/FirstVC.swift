//
//  ViewController.swift
//  App Of Ramadan
//
//  Created by Md AfzaL Hossain on 5/24/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import UIKit

class FirstVC: UIViewController {
    
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(FirstVC.time), userInfo: nil, repeats: false)
    }
    
    func time() {
        performSegue(withIdentifier: "toMainVC", sender: nil)
    }

}

