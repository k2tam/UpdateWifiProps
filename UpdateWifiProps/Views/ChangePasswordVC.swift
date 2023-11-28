//
//  ChangePasswordVC.swift
//  UpdateWifiProps
//
//  Created by k2 tam on 27/11/2023.
//

import UIKit

class ChangePasswordVC: UIViewController {
    @IBOutlet weak var changePasswordContainerView: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var imgTFIcon: UIImageView!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnTF: UILabel!
    
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var lbError: UILabel!
    
    @IBOutlet weak var lbDescription: UILabel!
    
    @IBOutlet weak var btnUpdate: UIButton!
    
    var changeWFPassModel:  ChangeWFPasswordModel
    
    var vm : ChangePasswordVM!
    
    var isDisplayError: Bool = false {
        didSet {
            if isDisplayError {
                errorView.isHidden = false
                
            }else{
                errorView.isHidden = true
            }
            
          
        }
    }
    
    var canUpdate: Bool = false {
        didSet {
            if canUpdate {
                btnUpdate.isEnabled = true
                btnUpdate.backgroundColor = UIColor(hex: "#4564ED")
            }else {
                btnUpdate.isEnabled = false
                btnUpdate.backgroundColor = UIColor(hex: "#D1D1D1")

            }
        }
    }
    
   
    
    init(changeWFPassModel: ChangeWFPasswordModel){
        self.changeWFPassModel = changeWFPassModel
        super.init(nibName: "ChangePasswordVC", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVM()
        setupUI()
        
        canUpdate = false
        isDisplayError = false
        tfPassword.delegate = self

    }

    @IBAction func btnPressed(_ sender: UIButton) {
        if let validPassword =  tfPassword.text {
            vm.didGetUpdatablePassword(password: validPassword)
        }
        
    }
    
    private func setupUI(){
        btnUpdate.setTitleColor(.white, for: .normal)
        btnUpdate.setTitleColor(.white, for: .disabled)

        btnUpdate.layer.cornerRadius = 8
        changePasswordContainerView.layer.cornerRadius = 8
        
        tfPassword.borderStyle = .none
        
        
        lbTitle.text = changeWFPassModel.name
        lbDescription.text = changeWFPassModel.desc
        
        tfPassword.text = changeWFPassModel.password
    }
    
    private func setupVM() {
        self.vm = ChangePasswordVM(passwordModel: changeWFPassModel)
        vm.delegate = self
    }
    
 
    
}

extension ChangePasswordVC: UITextFieldDelegate {
    
    /// check a character can be type in the pass text field
    /// - Parameters:
    ///   - textField: current textfield
    ///   - range: range description
    ///   - string: character inputed
    /// - Returns: Bool value allow input to pass textfield
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        vm.checkPassword(textField: textField, replacementString: string)

    }
}

extension ChangePasswordVC: ChangePasswordVMDelegate {
    
    //TODO: Hande error message here
    func didGetInputErrorMessage(message: String, willDisapear : Bool) {
        isDisplayError = true
        lbError.text = message
        
        
        if willDisapear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.isDisplayError = false
            }
        }
    
    }
    
   
    
    func didChangeCanUpdatePass(enableUpdate: Bool) {
        
        if enableUpdate {
            canUpdate = true
            isDisplayError = false
        }else {
            canUpdate = false
            isDisplayError = true
        }
        
    }

}

