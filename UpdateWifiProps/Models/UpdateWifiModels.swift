//
//  RenameWFModel.swift
//  UpdateWifiProps
//
//  Created by k2 tam on 28/11/2023.
//

import Foundation


enum eTypeRegexPattern: String{
    case wifiPassword = ".*[^A-Za-z0-9\\!\\@\\#\\$\\%\\(\\)\\:\\;\\.\\,\\_\\-].*"
    case wifiname = ".*[^A-Za-z0-9\\_\\.\\-\\s].*"
}

struct RenameWifiModel {
    var key: String
    var name: String
    var desc: String
    var wfNameLengthMaximum: Int
    var wifiName: String
}

struct ChangeWFPasswordModel {
    var key: String
    var name: String
    var desc: String
    var icon: String
    var passLengthMinimum: Int
    var password: String
    
}

