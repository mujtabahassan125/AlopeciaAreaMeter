//
//  SettingsVC.swift
//  AlopeciaAreaMeter
//
//  Created by Mujtaba Hassan on 08/04/2024.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func registerNibs() {
        tableView.register(UINib(nibName: String(describing: NameFormatViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: NameFormatViewCell.self))
        tableView.register(UINib(nibName: String(describing: TopNavTitleBarViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TopNavTitleBarViewCell.self))
        tableView.register(UINib(nibName: String(describing: DropboxViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: DropboxViewCell.self))
        
    }
    

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TopNavTitleBarViewCell.self)) as? TopNavTitleBarViewCell else { return UITableViewCell() }
            cell.setLabel(title: AppConstants.settingsLbl)
            cell.topNavTitleDelegate = self
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DropboxViewCell.self)) as? DropboxViewCell else { return UITableViewCell() }
            cell.setCellLabel(lblString: "About Us", isCheckBox: false, iconImage: UIImage(named: IconName.aboutUsIcon) ?? UIImage())
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NameFormatViewCell.self)) as? NameFormatViewCell else { return UITableViewCell() }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DropboxViewCell.self)) as? DropboxViewCell else { return UITableViewCell() }
            cell.setCellLabel(lblString: "Link drop-box", isCheckBox: true, iconImage: UIImage(named: IconName.dropBoxIcon) ?? UIImage())
            return cell
        default:
            return UITableViewCell()
        }
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension SettingsVC: TopNavProtocol {
    func popViewContoller() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
