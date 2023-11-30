//
//  RenameWFModel.swift
//  UpdateWifiProps
//
//  Created by k2 tam on 28/11/2023.
//

import Foundation


enum eTypeRegexPattern: String{
    case wifiName = ".*[^A-Za-z0-9\\_\\.\\-\\s].*"
    case wifiPassword = ".*[^A-Za-z0-9\\!\\@\\#\\$\\%\\(\\)\\:\\;\\.\\,\\_\\-].*"
}

struct RenameWifiModel {
    var key: String
    var name: String
    var desc: String
    var wfNameLengthMinimum: Int
    var wfNameLengthMaximum: Int
    var wifiName: String
}

struct ChangeWFPasswordModel {
    var key: String
    var name: String
    var desc: String
    var icon: String
    var passLengthMinimum: Int
    var passLengthMaximum: Int
    var password: String
    
}

