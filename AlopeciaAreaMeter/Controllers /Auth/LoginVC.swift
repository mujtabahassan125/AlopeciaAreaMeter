//
//  LoginVC.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 18/03/2024.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: LoginVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func registerNibs() {
        tableView.register(UINib(nibName: String(describing: AuthTextViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AuthTextViewCell.self))
        tableView.register(UINib(nibName: String(describing: AuthHeaderViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AuthHeaderViewCell.self))
        tableView.register(UINib(nibName: String(describing: AuthBtnsViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AuthBtnsViewCell.self))
    }
    
    init?(coder: NSCoder, viewModel: LoginVM) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension LoginVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthHeaderViewCell.self)) as? AuthHeaderViewCell else { return UITableViewCell() }
            cell.headerLbl.text = AppConstants.authHeader
            cell.headerTitle.text = AppConstants.authLogin
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthTextViewCell.self)) as? AuthTextViewCell else { return UITableViewCell() }
            cell.titleLbl.text = AppConstants.authEmailLbl
            cell.iconView.image = UIImage(named: IconName.email)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthTextViewCell.self)) as? AuthTextViewCell else { return UITableViewCell() }
            cell.titleLbl.text =  "Your \(AppConstants.authPasswordLbl)"
            cell.iconView.image = UIImage(named: IconName.password)
            cell.setPasswordUi()
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthBtnsViewCell.self)) as? AuthBtnsViewCell else { return UITableViewCell() }
            cell.setDataForLogin()
            cell.authActionsDelegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension LoginVC: AuthActionsProtocol {
    func authNavigation() {
        self.navigateToViewController(storyboardName: Storyboard.auth.rawValue, viewControllerIdentifier: String(describing: SignUpVC.self), viewModel: BaseViewModel()) { (vc: SignUpVC, nil) in
            return vc
        }
    }
    
    func authProccessing() {
        self.navigateToViewController(storyboardName: Storyboard.patient.rawValue, viewControllerIdentifier: String(describing: PatientHomeVC.self), viewModel: BaseViewModel()) { (vc: PatientHomeVC, nil) in
            return vc
        }
    }
    
}
