//
//  PatientHomeVC.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 23/03/2024.
//

import UIKit

class PatientHomeVC: UIViewController, UIViewControllerTransitioningDelegate {
    

    @IBOutlet weak var noDataStack: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sideMenuBackView: UIView!
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var addPatientBtn: UIButton!
    
    var sideMenuVC : SideMenuVC?
    override func viewDidLoad() {
        super.viewDidLoad()

        registerNibs()
        noDataStack.isHidden = true 
        sideMenuBackView.isHidden = true
        sideMenuView.isHidden = true
        
//        sideMenuView.layer.cornerRadius = 10
//        sideMenuView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        // Do any additional setup after loading the view.
    }
    
    private func registerNibs() {
        tableView.register(UINib(nibName: String(describing: HomePatientListViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HomePatientListViewCell.self))
    }
    

    private func hideView() {
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
        if (segue.identifier == AppConstants.sideMenuSegue)
        {
            if let controller = segue.destination as? SideMenuVC
            {
                self.sideMenuVC = controller
                self.sideMenuVC?.delegate = self
            }
        }
    }
    
    
    

    @IBAction func tappedOnSideSideMenuBg(_ sender: Any) {
        self.hideView()
    }
    @IBAction func searchAction(_ sender: Any) {
    }

    @IBAction func addPatientAction(_ sender: Any) {
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
        sideMenuView.isHidden = false
        self.sideMenuLeadingConstraint.constant = 0

    }

}

extension PatientHomeVC: SideMenuViewControllerDelegate {
    func hideSideMenu() {
        self.hideView()
    }
}

extension PatientHomeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HomePatientListViewCell.self)) as? HomePatientListViewCell else { return UITableViewCell() }
        return cell

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToViewController(storyboardName: Storyboard.records.rawValue, viewControllerIdentifier: String(describing: RecordsVC.self), viewModel: BaseViewModel()) { (vc: RecordsVC, nil) in
            return vc
        }
    }
    
    
}


