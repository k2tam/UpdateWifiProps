//
//  ChangePasswordVM.swift
//  UpdateWifiProps
//
//  Created by k2 tam on 27/11/2023.
//

import Foundation
import UIKit

enum ePasswordErrorType {
    case length
    case duplicate
    case character
    
    func errorText() -> String {
        switch self {
        case .length:
            "length not meet"
        case .duplicate:
            "wifi password is the same with the old one"
        case .character:
            "invalid character"
        }
    }
}


protocol ChangePasswordVMDelegate: AnyObject{
    //Function to enable or disable update password button
    func didChangeCanUpdatePass(enableUpdate: Bool)
    
    func didGetInputErrorMessage(message: String, willDisapear: Bool)

}

class ChangePasswordVM {
    
    let passwordModel: ChangeWFPasswordModel
    var delegate: ChangePasswordVMDelegate?
    
    init(passwordModel: ChangeWFPasswordModel) {
        self.passwordModel = passwordModel
    }
    
    
    //TODO: Handle error message here
    func firePasswordErrorMessage(type: ePasswordErrorType){
        if type == .character {
            delegate?.didGetInputErrorMessage(message: type.errorText(), willDisapear: true)
        }else {
            delegate?.didGetInputErrorMessage(message: type.errorText(), willDisapear: false)
        }
      
    }
    
    
    //TODO: Handle updatable password here
    func didGetUpdatablePassword(password: String){
        print(password)
    }
    
    
    
    /// Function to check a character is able to input is pass textfield
    /// - Parameters:
    ///   - textField: textfield before input
    ///   - string: character input
    /// - Returns: true to allow character get in textfield otherwise not allow it
    func checkPassword(textField: UITextField, replacementString string: String) -> Bool {
        
        //string is character inputed
        if string.range(of: eTypeRegexPattern.wifiPassword.rawValue, options: .regularExpression) != nil {
            //Fire error message because character input is invalid
            firePasswordErrorMessage(type: .character)
            

            
            //Case  pass does not matches the regex.
            return false
            
        } else {
            //Case pass matches the regex.
            var curPassTxt = ""
            
            if textField.text == nil {
                curPassTxt = string
            }else if string == "" {
                //Case backspace character
                curPassTxt = String(textField.text!.dropLast())
            }
            else {
                curPassTxt = textField.text! + string
            }
            
            //Check length of pass
            if curPassTxt.count >= passwordModel.passLengthMinimum {
               
                delegate?.didChangeCanUpdatePass(enableUpdate: true)
                
            }else {
                //Fire error password not meet minimum length
                firePasswordErrorMessage(type: .length)
                
                //Disable update because length condition not met
                delegate?.didChangeCanUpdatePass(enableUpdate: false)
            }
            
            //Check new pass vs old pass
            if curPassTxt ==  passwordModel.password{
                //Fire error message because password is the same with the old one
                firePasswordErrorMessage(type: .duplicate)
                
                //Disable update because new password is the same with the old one
                delegate?.didChangeCanUpdatePass(enableUpdate: false)
            }
            
            return true
        }
    }
    
    
}
