//
//  PatientHomeVC.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 23/03/2024.
//

import UIKit

class PatientHomeVC: UIViewController, UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func searchAction(_ sender: Any) {
    }


    @IBAction func sideMenuAction(_ sender: Any) {
    //    presentSideMenuController()

        self.navigateToViewController(storyboardName: Storyboard.patient.rawValue, viewControllerIdentifier: String(describing: SideMenuVC.self), viewModel: BaseViewModel()) { (vc: SideMenuVC, viewModel) in
            //vc.viewModel = viewModel as? LoginVM
            return vc
        }
    }
    
    func presentSideMenuController() {
        let sideMenuController = SideMenuVC()
        sideMenuController.modalPresentationStyle = .custom
        sideMenuController.transitioningDelegate = self // Set transitioning delegate
        
        // Present the side menu controller
        present(sideMenuController, animated: true, completion: nil)
    }
    
    // MARK: - UIViewControllerTransitioningDelegate
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return SideMenuPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInPresentationAnimator(isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInPresentationAnimator(isPresenting: false)
    }
}

