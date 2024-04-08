//
//  PasswordRestSuccessful.swift
//  AlopeciaAreaMeter
//
//  Created by Mujtaba Hassan on 08/04/2024.
//

import UIKit

class PasswordResetSuccessful: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func updatePasswordAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
