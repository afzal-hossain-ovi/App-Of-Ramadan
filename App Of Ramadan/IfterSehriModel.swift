//
//  IfterSehriModel.swift
//  App Of Ramadan
//
//  Created by Md AfzaL Hossain on 5/26/17.
//  Copyright © 2017 Md AfzaL Hossain. All rights reserved.
//

import Foundation



class IfterSehriModel {
    var exactIfterTime: String!
    var exactSehriTime: String!
    
    
    func plusMinusIfterTime(zillaName: String,ifterTime: String) {
        let separeteIfterTime = ifterTime.components(separatedBy: ":")
        let hour = separeteIfterTime[0]
        let minute = Int(separeteIfterTime[1])!
        switch zillaName {
        case "Khulna","Faridpur","Manikganj","Mymensingh":
            exactIfterTime = "\(hour):\(minute + 1)"
            break
        case "Tangail","Narail":
            exactIfterTime = "\(hour):\(minute + 2)"
            break
        case "Sherpur","Jessore","Magura","Satkhira","Sirajganj":
            exactIfterTime = "\(hour):\(minute + 3)"
            break
        case "Jamalpur","Rajbari","Jhenaidah":
            exactIfterTime = "\(hour):\(minute + 4)"
            break
        case "Chuadanga","Kushtia","Pabna":
            exactIfterTime = "\(hour):\(minute + 5)"
            break
        case "Bogra","Natore","Gaibandha":
            exactIfterTime = "\(hour):\(minute + 6)"
            break
        case "Rajshahi","Meherpur","Naogan","Kurigram":
            exactIfterTime = "\(hour):\(minute + 7)"
            break
        case "Rangpur","Joypurhat","Lalmonirhat":
            exactIfterTime = "\(hour):\(minute + 8)"
            break
        case "Chapainababganj","Dinajpur","Nilphamari":
            exactIfterTime = "\(hour):\(minute + 10)"
            break
        case "Panchagarh","Thakurgaon":
            exactIfterTime = "\(hour):\(minute + 12)"
            break
        case "Pirojpur","Kishoregonj","Madaripur","Narayanganj":
            exactIfterTime = "\(hour):\(minute - 1)"
            break
        case "Jhalokati","Munshiganj","Narsingdi","Shariatpur","Sunamganj":
            exactIfterTime = "\(hour):\(minute - 2)"
            break
        case "Barisal","Barguna","Patuakhali","Bramanbaria","Chadpur","Habiganj":
            exactIfterTime = "\(hour):\(minute - 3)"
            break
        case "Sylhet","Bhola","Comilla","Lakshmipur":
            exactIfterTime = "\(hour):\(minute - 4)"
            break
        case "Noakhali","Maulvibazar":
            exactIfterTime = "\(hour):\(minute - 5)"
            break
        case "Feni":
            exactIfterTime = "\(hour):\(minute - 6)"
            break
        case "Khagrachhari":
            exactIfterTime = "\(hour):\(minute - 8)"
            break
        case "Chittagong":
            exactIfterTime = "\(hour):\(minute - 9)"
            break
        case "Rangamati":
            exactIfterTime = "\(hour):\(minute - 10)"
            break
        case "Bandarban","Cox's bazar":
            exactIfterTime = "\(hour):\(minute - 11)"
            break
        default:
            exactIfterTime = ifterTime
        }
        
    }
    
    func plusMinusSehriTime(zillaName: String,sehriTime: String) {
        let separeteSehriTime = sehriTime.components(separatedBy: ":")
        let hour = separeteSehriTime[0]
        let minute = Int(separeteSehriTime[1])!
        switch zillaName {
        case "Bogra","Joypurhat","Dinajpur","Thakurgaon","Lakshmipur","Cox's bazar":
            exactSehriTime = "\(hour):\(minute + 1)"
            break
        case "Manikganj","Shariatpur":
            exactSehriTime = "\(hour):\(minute + 2)"
            break
        case "Faridpur","Madaripur","Barisal","Bhola":
            exactSehriTime = "\(hour):\(minute + 3)"
            break
        case "Rajbari","Pabna","Natore","Jhalokati":
            exactSehriTime = "\(hour):\(minute + 4)"
            break
        case "Magura","Kushtia","Rajshahi","Patuakhali":
            exactSehriTime = "\(hour):\(minute + 5)"
            break
        case "Narail","Jhenaidah","Chapainababganj","Barguna","Bagerhat":
            exactSehriTime = "\(hour):\(minute + 6)"
            break
        case "Jessore","Meherpur","Khulna":
            exactSehriTime = "\(hour):\(minute + 7)"
            break
        case "Satkhira":
            exactSehriTime = "\(hour):\(minute + 9)"
            break
        case "Gazipur","Rangpur","Panchagarh","Chittagong":
            exactSehriTime = "\(hour):\(minute - 1)"
            break
        case "Bandarban","Comilla","Feni","Narsingdi","Gaibandha":
            exactSehriTime = "\(hour):\(minute - 2)"
            break
        case "Rangamati","Sherpur","Lalmonirhat","Kurigram":
            exactSehriTime = "\(hour):\(minute - 3)"
            break
        case "Bramanbaria","Kishoregonj":
            exactSehriTime = "\(hour):\(minute - 4)"
            break
        case "Khagrachhari","Netrakona":
            exactSehriTime = "\(hour):\(minute - 5)"
            break
        case "Habiganj":
            exactSehriTime = "\(hour):\(minute - 6)"
            break
        case "Maulvibazar","Sunamganj":
            exactSehriTime = "\(hour):\(minute - 8)"
            break
        case "Sylhet":
            exactSehriTime = "\(hour):\(minute - 9)"
            break
        default:
            exactSehriTime = sehriTime
        }
    }
}
