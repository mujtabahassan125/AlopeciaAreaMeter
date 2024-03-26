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
    
    var sideMenuItems = [SideMenu]()
    var delegate : SideMenuViewControllerDelegate?

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerNib()
        populateSideMenuItems()
    }
    
    private func setupUI() {
        
       // let sideMenuView = self.view // or however you reference your side menu's view
        mainView.layer.cornerRadius = 10
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    private func populateSideMenuItems() {
        sideMenuItems.append(SideMenu(title: AppConstants.patientLbl, image: IconName.phoneUserList))
        sideMenuItems.append(SideMenu(title: AppConstants.contactsLbl, image: IconName.phone))
        sideMenuItems.append(SideMenu(title: AppConstants.cameraLbl, image: IconName.camera))
        sideMenuItems.append(SideMenu(title: AppConstants.settingsLbl, image: IconName.settings))
        sideMenuItems.append(SideMenu(title: AppConstants.logoutLbl, image: IconName.logout))
        
    }
    
    private func registerNib() {
        tableView.register(UINib(nibName: String(describing: SideMenuListViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SideMenuListViewCell.self))
        tableView.register(UINib(nibName: String(describing: SideMenuHeaderViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SideMenuHeaderViewCell.self))
    }
    
    func navigateToCamera() {
        self.navigateToViewController(storyboardName: Storyboard.patient.rawValue, viewControllerIdentifier: String(describing: CameraVC.self), viewModel: BaseViewModel()) { (vc: CameraVC, nil) in
          //  vc.viewModel = viewModel as? BaseViewModel
            return vc
        }
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
        default:
            break
        }
    
    }
    // swiftlint: enable cyclomatic_complexity
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

struct SideMenu {
    var title: String = ""
    var image: String = ""
    
    
    init(title: String, image: String) {
        self.title = title
        self.image = image
    }
}
