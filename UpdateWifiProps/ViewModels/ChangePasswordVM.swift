//
//  ChangePasswordVM.swift
//  UpdateWifiProps
//
//  Created by k2 tam on 27/11/2023.
//

import Foundation
import UIKit


protocol ChangePasswordVMDelegate: AnyObject{
    //Function to enable or disable update password button
    func didChangeCanUpdatePass(enableUpdate: Bool)
}


class ChangePasswordVM {
    let passwordModel: ChangeWFPasswordModel
    var canUpdatePass: Bool = false
    var delegate: ChangePasswordVMDelegate?
    

    init(passwordModel: ChangeWFPasswordModel) {
        self.passwordModel = passwordModel
    }
    
    
    //TODO: Handle updatable password here
    func didGetUpdatablePassword(password: String){
        print(password)
    }
    
    func checkPassword(textField: UITextField, replacementString string: String) -> Bool {
        
        //string is character inputed
        if string.range(of: TypeRegexPattern.wifiPassword.rawValue, options: .regularExpression) != nil {
            //Case  pass does not matches the regex.
            return false
            
        } else {
            //Case pass matches the regex.
            var curPassTxt = ""
            
            if textField.text == nil {
                curPassTxt = string
            }else {
                curPassTxt = textField.text! + string
            }
            
            //Check length of pass
            if curPassTxt.count >= passwordModel.passwordLimit {
                delegate?.didChangeCanUpdatePass(enableUpdate: true)
            }else {
                //Disable update because length condition not met
                delegate?.didChangeCanUpdatePass(enableUpdate: false)
            }
            
            //Check new pass vs old pass
            if curPassTxt ==  passwordModel.password{
                //Disable update because new password is the same with old password
                delegate?.didChangeCanUpdatePass(enableUpdate: false)
            }
            
            return true
        }
    }
    
    
}
