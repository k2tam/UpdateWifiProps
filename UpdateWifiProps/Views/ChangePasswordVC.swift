//
//  ChangePasswordVC.swift
//  UpdateWifiProps
//
//  Created by k2 tam on 27/11/2023.
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    @IBOutlet weak var bottomConstraintUpdateBtn: NSLayoutConstraint!
    
    @IBOutlet weak var changePasswordContainerView: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var imgTFIcon: UIImageView!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var btnHidePassword: UIButton!
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var lbError: UILabel!
    
    @IBOutlet weak var lbDescription: UILabel!
    
    @IBOutlet weak var btnUpdate: UIButton!
    
    var changeWFPassModel:  ChangeWFPasswordModel
    
    var vm : ChangePasswordVM!
    
    var isHidePassword: Bool = false
    
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVM()
        setupUI()
        setupKeyboardHandler()
        canUpdate = false
        isDisplayError = false
        tfPassword.delegate = self

    }
    
    
    @IBAction func hidePasswordPressed(_ sender: Any) {
        
        isHidePassword.toggle()
        tfPassword.isSecureTextEntry = isHidePassword
        
        if isHidePassword {
            self.btnHidePassword.setTitle("Hiện", for: .normal)
        }else{
            btnHidePassword.setTitle("Ẩn", for: .normal)
        }
        
        btnHidePassword.isHighlighted = false

        
        
        
       
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
                
                
                if let curWFName = self.tfPassword.text {
                    self.vm.checkMinimumLengthPassword(length: curWFName.count)
                }
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

//Methods handle keyboard
extension ChangePasswordVC {
    func setupKeyboardHandler() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.5) {
                self.bottomConstraintUpdateBtn.constant = keyboardSize.height + 16
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.5) {
            self.bottomConstraintUpdateBtn.constant = 48
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
}



