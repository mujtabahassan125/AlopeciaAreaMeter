//
//  AuthBtnsViewCell.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 17/03/2024.
//

import UIKit

protocol AuthActionsProtocol {
    func authNavigation()
    func authProccessing()
}

class AuthBtnsViewCell: UITableViewCell {

    @IBOutlet weak var authActionBtn: UIButton!
    @IBOutlet weak var accountLbl: UILabel!
    @IBOutlet weak var bottomStack: UIStackView!
    @IBOutlet weak var continueWithGoogleBtn: UIButton!
    @IBOutlet weak var sepratorView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var registerLoginLbl: UILabel!
    var isLogin: Bool = false
    var authActionsDelegate: AuthActionsProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set border color of the view
        continueWithGoogleBtn.setImage(UIImage(named: IconName.google), for: .normal)
        continueWithGoogleBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0) // Adjust as needed
        
        continueWithGoogleBtn.layer.borderColor = UIColor.black.cgColor
        continueWithGoogleBtn.layer.borderWidth = 1.0 // You can adjust the width as needed
        continueWithGoogleBtn.layer.cornerRadius = 6.0 // You can adjust the corner radius as needed
        
//        // Set button title
//        let attributedString = NSAttributedString(string: AppConstants.authRegisterBtn, attributes: [
//            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
//            NSAttributedString.Key.foregroundColor: UIColor.black // You can set the color as needed
//        ])
//        authActionBtn.setAttributedTitle(attributedString, for: .normal)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func isRegistrationAction(_ sender: Any) {
        authActionsDelegate?.authNavigation()
    }
    
    func setDataForLogin() {
        sepratorView.isHidden = false
        registerLoginLbl.text = AppConstants.authRegisterBtn
       
        
    }
    
    func setDataForSignup() {
        sepratorView.isHidden = true
        continueWithGoogleBtn.isHidden = true
        sepratorView.isHidden = true
        registerLoginLbl.text = AppConstants.authLogin
        loginBtn.setTitle(AppConstants.authRegisterBtn, for: .normal)
    }
    

    
    
    
    @IBAction func authNavigationAction(_ sender: Any) {
        authActionsDelegate?.authNavigation()
    }
    @IBAction func AuthActionBtn(_ sender: Any) {
        authActionsDelegate?.authProccessing()
    }
    @IBAction func signWithGoogleAction(_ sender: Any) {
    }
}
