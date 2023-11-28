//
//  RenameWFVM.swift
//  UpdateWifiProps
//
//  Created by k2 tam on 28/11/2023.
//

import Foundation


import UIKit

enum eWFNamedErrorType  {
    case length
    case duplicate
    case character
    
    func errorText() -> String {
        switch self {
        case .length:
            "length not meet"
        case .duplicate:
            "wifi name is the same with the old one"
        case .character:
            "invalid character"
        }
    }
}


protocol RenameWiFiVMDelegate: AnyObject{
    //Function to enable or disable update password button
    func didChangeCanUpdateWFName(enableUpdate: Bool)

    func didGetInputErrorMessage(message: String, willDisapear: Bool)
}

class RenameWifiVM {
    
    let renameWFModel: RenameWifiModel
    var delegate: RenameWiFiVMDelegate?
    
    init(renameWFModel: RenameWifiModel) {
        self.renameWFModel = renameWFModel
    }
    
    
    
    func fireWifiNameError(type: eWFNamedErrorType){
        if type == .character {
            delegate?.didGetInputErrorMessage(message: type.errorText(), willDisapear: true)
        }else {
            delegate?.didGetInputErrorMessage(message: type.errorText(), willDisapear: false)
        }
        
     
    }
    
    
    //TODO: Handle updatable password here
    func didGetUpdatableNameWifi(nameWifi: String){
        print(nameWifi)
    }
    
    
    
   
    func checkWifiNameInput(textField: UITextField, replacementString string: String) -> Bool {
        
        //string is character inputed
        if string.range(of: eTypeRegexPattern.wifiname.rawValue, options: .regularExpression) != nil {
            
            //Fire error message because character input is invalid
            fireWifiNameError(type: .character)
            
            //Case  input character for wifi name does not matches the regex.
            return false
            
        } else {
            //Case character matches the regex.
            var curWifiName = ""
            
            if textField.text == nil {
                curWifiName = string
            }else if string == "" {
                //Case backspace character
                curWifiName = String(textField.text!.dropLast())
            }
            else {
                curWifiName = textField.text! + string
            }
            
            
            
            //Check length of wifi name
            if curWifiName.count <= renameWFModel.wfNameLengthMaximum {
               
                delegate?.didChangeCanUpdateWFName(enableUpdate: true)
                
            }else {
                //Fire error wifi name is out of maximum length
                fireWifiNameError(type: .length)
                
                //Disable update because length condition not met
                delegate?.didChangeCanUpdateWFName(enableUpdate: false)
                
                return false
            }
            
            
            //Check new wifi name vs old wifi name
            if curWifiName == renameWFModel.wifiName{
                //Fire error message because wifi name is the same with the old one
                fireWifiNameError(type: .duplicate)
                
                //Disable update because new wifi name is the same with the old one
                delegate?.didChangeCanUpdateWFName(enableUpdate: false)
            
            }
            
            return true
        }
    }
    
    
}
