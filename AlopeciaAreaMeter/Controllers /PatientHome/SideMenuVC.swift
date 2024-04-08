//
//  SideMenuVC.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 24/03/2024.
//

import UIKit

protocol SideMenuViewControllerDelegate {
    func hideSideMenu()
}

class SideMenuVC: UIViewController {
    
    var sideMenuItems = [ListModel]()
    var delegate : SideMenuViewControllerDelegate?

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //applyRoundedCorners()
        registerNib()
        populateSideMenuItems()
    }
    
    private func setupUI() {
        
       // let sideMenuView = self.view // or however you reference your side menu's view
        mainView.layer.cornerRadius = 10
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    private func applyRoundedCorners() {
        // Create a path for rounded corners
        let cornerRadius: CGFloat = 20 // Adjust as per your preference
        let maskPath = UIBezierPath(roundedRect: mainView.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        // Create a shape layer with the rounded path
        let maskLayer = CAShapeLayer()
        maskLayer.frame = mainView.bounds
        maskLayer.path = maskPath.cgPath
        
        // Apply the mask to the side menu view's layer
        mainView.layer.mask = maskLayer
    }
    private func populateSideMenuItems() {
        sideMenuItems.append(ListModel(title: AppConstants.patientLbl, image: IconName.phoneUserList, hint: ""))
        sideMenuItems.append(ListModel(title: AppConstants.contactsLbl, image: IconName.phone, hint: ""))
        sideMenuItems.append(ListModel(title: AppConstants.cameraLbl, image: IconName.camera, hint: ""))
        sideMenuItems.append(ListModel(title: AppConstants.settingsLbl, image: IconName.settings, hint: ""))
        sideMenuItems.append(ListModel(title: AppConstants.logoutLbl, image: IconName.logout, hint: ""))
        
    }
    
    private func registerNib() {
        tableView.register(UINib(nibName: String(describing: SideMenuListViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SideMenuListViewCell.self))
        tableView.register(UINib(nibName: String(describing: SideMenuHeaderViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SideMenuHeaderViewCell.self))
    }
    
    func navigateToCamera() {
        self.navigateToViewController(storyboardName: Storyboard.patient.rawValue, viewControllerIdentifier: String(describing: CameraVC.self), viewModel: BaseViewModel()) { (vc: CameraVC, nil) in
            return vc
        }
    }
    
    func navigateToSettings() {
        self.navigateToViewController(storyboardName: Storyboard.settings.rawValue, viewControllerIdentifier: String(describing: SettingsVC.self), viewModel: BaseViewModel()) { (vc: SettingsVC, nil) in
            return vc
        }
        
    }
    
    func logout() {
        self.navigationController?.popToRootViewController(animated: true)
    }


}

extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SideMenuListViewCell.self)) as? SideMenuListViewCell else { return  UITableViewCell() }
        cell.setCellData(data: sideMenuItems[indexPath.row])
        cell.selectionStyle = .none
        return cell

    }
    // swiftlint: disable cyclomatic_complexity
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.hideSideMenu()
        switch indexPath.row {
        case 2:
            navigateToCamera()
        case 3:
            navigateToSettings()
        case 4:
            logout() 
        default:
            break
        }
    
    }
    // swiftlint: enable cyclomatic_complexity
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

