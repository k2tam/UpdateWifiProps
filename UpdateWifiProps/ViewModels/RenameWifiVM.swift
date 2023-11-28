//
//  RenameWFVM.swift
//  UpdateWifiProps
//
//  Created by k2 tam on 28/11/2023.
//

import Foundation


import UIKit

enum eWFNamedErrorType {
    case length
    case duplicate
    case character
}


protocol RenameWiFiVMDelegate: AnyObject{
    //Function to enable or disable update password button
    func didChangeCanUpdateWFName(enableUpdate: Bool)
}

class RenameWifiVM {
    
    let renameWFModel: RenameWifiModel
    var delegate: RenameWiFiVMDelegate?
    
    init(renameWFModel: RenameWifiModel) {
        self.renameWFModel = renameWFModel
    }
    
    
    //TODO: Handle error message here
    func fireWifiNameErrorMessage(type: ePasswordErrorType){
        switch type {
        case .length:
            print("length not meet")
        case .duplicate:
            print("password is the same with the old one")
        case .character:
            print("invalid character")

        }
    }
    
    
    //TODO: Handle updatable password here
    func didGetUpdatablePassword(password: String){
        print(password)
    }
    
    
    
   
    func checkWifiNameInput(textField: UITextField, replacementString string: String) -> Bool {
        
        //string is character inputed
        if string.range(of: eTypeRegexPattern.wifiname.rawValue, options: .regularExpression) != nil {
            //Fire error message because character input is invalid
            fireWifiNameErrorMessage(type: .character)

            
            //Case  input character for wifi name does not matches the regex.
            return false
            
        } else {
            //Case character matches the regex.
            var curPassTxt = ""
            
            if textField.text == nil {
                curPassTxt = string
            }else {
                curPassTxt = textField.text! + string
            }
            
            //Check length of wifi name
            if curPassTxt.count <= renameWFModel.wfNameLengthMaximum {
               
                delegate?.didChangeCanUpdateWFName(enableUpdate: true)
                
            }else {
                //Fire error wifi name is out of maximum length
                fireWifiNameErrorMessage(type: .length)
                
                //Disable update because length condition not met
                delegate?.didChangeCanUpdateWFName(enableUpdate: false)
                return false
            }
            
            //Check new wifi name vs old wifi name
            if curPassTxt ==  renameWFModel.name{
                //Fire error message because wifi name is the same with the old one
                fireWifiNameErrorMessage(type: .duplicate)
                
                //Disable update because new wifi name is the same with the old one
                delegate?.didChangeCanUpdateWFName(enableUpdate: false)
            }
            
            return true
        }
    }
    
    
}
