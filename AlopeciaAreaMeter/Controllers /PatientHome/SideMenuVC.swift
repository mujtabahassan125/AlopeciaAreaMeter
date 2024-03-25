//
//  SideMenuVC.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 24/03/2024.
//

import UIKit

class SideMenuVC: UIViewController {
    
    var sideMenuItems = [SideMenu]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.dataSource = self
//        tableView.delegate = self
        registerNib()
        populateSideMenuItems()
        


        // Do any additional setup after loading the view.
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return sideMenuItems.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SideMenuHeaderViewCell.self)) as? SideMenuHeaderViewCell else { return  UITableViewCell() }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SideMenuListViewCell.self)) as? SideMenuListViewCell else { return  UITableViewCell() }
          //  cell.setCell(data: sideMenuItems[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
    // swiftlint: disable cyclomatic_complexity
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    // swiftlint: enable cyclomatic_complexity
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return UITableView.automaticDimension
        default:
            return 0
        }
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
