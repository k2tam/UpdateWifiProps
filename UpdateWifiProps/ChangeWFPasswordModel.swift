//
//  ChangeWFPasswordModel.swift
//  UpdateWifiProps
//
//  Created by k2 tam on 27/11/2023.
//

import Foundation

enum TypeRegexPattern: String{
    case wifiPassword = ".*[^A-Za-z0-9\\!\\@\\#\\$\\%\\(\\)\\:\\;\\.\\,\\_\\-].*"
    case wifiname = ".*[^A-Za-z0-9\\_\\.\\-\\s].*"
}

struct ChangeWFPasswordModel {
    var key: String
    var name: String
    var desc: String
    var icon: String
    var passwordLimit: Int
    var password: String
    
}
