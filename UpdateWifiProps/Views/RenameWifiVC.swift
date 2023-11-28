//
//  RemaneWifiVC.swift
//  UpdateWifiProps
//
//  Created by k2 tam on 28/11/2023.
//

import UIKit

class RenameWifiVC: UIViewController {
    var renameWFModel: RenameWifiModel
    
    @IBOutlet weak var renameContainerView: UIStackView!
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfNameWifi: UITextField!
    
    
    @IBOutlet weak var lbErrorMessage: UILabel!
    @IBOutlet weak var lbDesc: UILabel!
    
    @IBOutlet weak var btnUpdate: UIButton!
    
    var vm: RenameWifiVM!
    
    var isDisplayError: Bool = false {
        didSet {
            if isDisplayError {
                lbErrorMessage.isHidden = false
                
            }else{
                lbErrorMessage.isHidden = true

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
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupVM()
        
        tfNameWifi.delegate = self
        canRename = false

    }

    private func setupUI(){
        btnUpdate.setTitleColor(.white, for: .normal)
        btnUpdate.setTitleColor(.white, for: .disabled)

        btnUpdate.layer.cornerRadius = 8
        renameContainerView.layer.cornerRadius = 8
        
        tfNameWifi.borderStyle = .none
        
        //set props
        
        lbTitle.text = renameWFModel.name
        lbDesc.text = renameWFModel.desc
        tfNameWifi.text = renameWFModel.wfName
    }
    
    private func setupVM() {
        self.vm = RenameWifiVM(renameWFModel: self.renameWFModel)
        vm.delegate = self
    }

    @IBAction func btnUpdatePressed(_ sender: UIButton) {
    }
 

}

extension RenameWifiVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        vm.checkWifiNameInput(textField: textField, replacementString: string)
    }
}

extension RenameWifiVC: RenameWiFiVMDelegate {
    func didChangeCanUpdateWFName(enableUpdate: Bool) {
        
    }
    
    
}
