//
//  SideMenuVC.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 24/03/2024.
//

import UIKit

protocol HamburgerViewControllerDelegate {
    func hideHamburgerMenu()
}

class SideMenuVC: UIViewController {
    
    var sideMenuItems = [SideMenu]()
    var delegate : HamburgerViewControllerDelegate?

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
        
        mainView.layer.cornerRadius = 10
        
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
        return cell

    }
    // swiftlint: disable cyclomatic_complexity
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
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
