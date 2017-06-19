//
//  QuranHadithModel.swift
//  App Of Ramadan
//
//  Created by Md AfzaL Hossain on 5/30/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import Foundation


class QuranHadithMasalahModel {
    
    private var _allDetails: String!
    private var _allTitle: String!
    
    
    
    var allDetails: String {
        return _allDetails
    }
    var allTitle: String {
        return _allTitle
    }

    init(title: String,details: String) {
        self._allDetails = details
        self._allTitle = title
    }
    
    
    
}
