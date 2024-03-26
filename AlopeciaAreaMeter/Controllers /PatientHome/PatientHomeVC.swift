//
//  PatientHomeVC.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 23/03/2024.
//

import UIKit

class PatientHomeVC: UIViewController, UIViewControllerTransitioningDelegate, HamburgerViewControllerDelegate {

    @IBOutlet weak var sideMenuBackView: UIView!
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideMenuView: UIView!
    
    var sideMenuVC : SideMenuVC?
    override func viewDidLoad() {
        super.viewDidLoad()

        sideMenuBackView.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    func hideHamburgerMenu() {
        self.hideHamburgerView()
    }
    
    private func hideHamburgerView() {
//        UIView.animate(withDuration: 0.1) {
//            self.sideMenuLeadingConstraint.constant = 10
//            self.view.layoutIfNeeded()
//        } completion: { (status) in
//            self.sideMenuBackView.alpha = 0.0
//            UIView.animate(withDuration: 0.1) {
//                self.sideMenuLeadingConstraint.constant = -280
//                self.view.layoutIfNeeded()
//            } completion: { (status) in
//                self.sideMenuBackView.isHidden = true
//             //   self.isHamburgerMenuShown = false
//            }
//        }
        
        sideMenuBackView.isHidden = true
        self.sideMenuLeadingConstraint.constant = -280
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "hamburgerSegue")
        {
            if let controller = segue.destination as? SideMenuVC
            {
                self.sideMenuVC = controller
                self.sideMenuVC?.delegate = self
            }
        }
    }
    
    
    

    @IBAction func tappedOnSideSideMenuBg(_ sender: Any) {
        
        self.hideHamburgerView()
        
    }
    @IBAction func searchAction(_ sender: Any) {
    }


    @IBAction func sideMenuAction(_ sender: Any) {
        
//        UIView.animate(withDuration: 0.1) {
//            self.sideMenuLeadingConstraint.constant = 10
//            self.view.layoutIfNeeded()
//        } completion: { (status) in
//            self.sideMenuBackView.alpha = 0.75
//            self.sideMenuBackView.isHidden = false
//            UIView.animate(withDuration: 0.1) {
//                self.sideMenuLeadingConstraint.constant = 0
//                self.view.layoutIfNeeded()
//            } completion: { (status) in
//               // self.isHamburgerMenuShown = true
//            }
//
//        }
//
//        self.sideMenuBackView.isHidden = false
        sideMenuBackView.isHidden = false
        self.sideMenuLeadingConstraint.constant = 0

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

