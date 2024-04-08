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
            // self.showAuthController()
            self.navigateAsRootViewController()
        }
    }
    
    func showAuthController() {
        self.navigateToViewController(storyboardName: Storyboard.auth.rawValue, viewControllerIdentifier: String(describing: LoginVC.self), viewModel: LoginVM()) { (vc: LoginVC, viewModel) in
            vc.viewModel = viewModel as? LoginVM
            return vc
        }
    }
    
    func navigateAsRootViewController() {
        // Find the current UIWindowScene
        setRootViewController(storyboardName: Storyboard.auth.rawValue, viewControllerIdentifier: String(describing: LoginVC.self), viewModel: LoginVM()) { (vc: LoginVC, viewModel) in
            vc.viewModel = viewModel as? LoginVM
            return vc
        }
    }


}

