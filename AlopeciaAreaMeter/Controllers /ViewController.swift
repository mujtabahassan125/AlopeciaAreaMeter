//
//  ViewController.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 16/03/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 3 seconds delay
                  self.showAuthController()
        }
    }
    
    func showAuthController() {
        self.navigateToViewController(storyboardName: Storyboard.auth.rawValue, viewControllerIdentifier: String(describing: LoginVC.self), viewModel: LoginViewModel()) { (vc: LoginVC, viewModel) in
            vc.viewModel = viewModel as? LoginViewModel
            return vc
        }
    }


}

