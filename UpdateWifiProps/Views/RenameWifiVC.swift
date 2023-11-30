//
//  RemaneWifiVC.swift
//  UpdateWifiProps
//
//  Created by k2 tam on 28/11/2023.
//

import UIKit

class RenameWifiVC: UIViewController {
    
    @IBOutlet weak var bottomConstraintUpdateBtn: NSLayoutConstraint!
    
    @IBOutlet weak var renameContainerView: UIStackView!
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfNameWifi: UITextField!
    
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var lbErrorMessage: UILabel!
    @IBOutlet weak var lbDesc: UILabel!
    
    @IBOutlet weak var btnUpdate: UIButton!
    
    var renameWFModel: RenameWifiModel

    var vm: RenameWifiVM!
    
    var isDisplayError: Bool = false {
        didSet {
            if isDisplayError {
                errorView.isHidden = false
                
            }else{
                errorView.isHidden = true
            }
        }
    }
    
    var canRename: Bool = false {
        didSet {
            if canRename {
                btnUpdate.isEnabled = true
                btnUpdate.backgroundColor = UIColor(hex: "#4564ED")
            }else {
                btnUpdate.isEnabled = false
                btnUpdate.backgroundColor = UIColor(hex: "#D1D1D1")

            }
        }
    }
    
    init(renameWFModel: RenameWifiModel) {
        self.renameWFModel = renameWFModel
        super.init(nibName: "RenameWifiVC", bundle: Bundle.main)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupVM()
        
        tfNameWifi.delegate = self
        canRename = false
        isDisplayError = false
        
        setupKeyboardHandler()
        
        
    }
    

    private func setupUI(){
        isDisplayError = false
        
        btnUpdate.setTitleColor(.white, for: .normal)
        btnUpdate.setTitleColor(.white, for: .disabled)

        btnUpdate.layer.cornerRadius = 8
        renameContainerView.layer.cornerRadius = 8
        
        tfNameWifi.borderStyle = .none
        
        //set props
        
        lbTitle.text = renameWFModel.name
        lbDesc.text = renameWFModel.desc
        tfNameWifi.text = renameWFModel.wifiName
    }
    
    private func setupVM() {
        self.vm = RenameWifiVM(renameWFModel: self.renameWFModel)
        vm.delegate = self
    }

    @IBAction func btnUpdatePressed(_ sender: UIButton) {
        if let validWifiName =  tfNameWifi.text {
            vm.didGetUpdatableNameWifi(nameWifi: validWifiName)
        }
    }
 

}

extension RenameWifiVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        vm.checkWifiNameInput(textField: textField, replacementString: string)
    }
}

extension RenameWifiVC: RenameWiFiVMDelegate {
    
    //TODO: Hande error message here
    func didGetInputErrorMessage(message: String, willDisapear : Bool) {
        isDisplayError = true
        lbErrorMessage.text = message
        
        
        if willDisapear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                self.isDisplayError = false
                
                if let curWFName = self.tfNameWifi.text {
                    self.vm.checkMinimumLengthWFName(length: curWFName.count)
                }
                
            }
            
            
        }
    }
    
    func didChangeCanUpdateWFName(enableUpdate: Bool) {
        if enableUpdate {
            canRename = true
            isDisplayError = false
        }else {
            canRename = false
            isDisplayError = true
        }
    }
    
    
   
}

//Methods handle keyboard
extension RenameWifiVC {
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


