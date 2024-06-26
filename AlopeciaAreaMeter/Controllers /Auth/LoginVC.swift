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
        tableView.register(UINib(nibName: String(describing: ForgetLblViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ForgetLblViewCell.self))
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
       return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthHeaderViewCell.self)) as? AuthHeaderViewCell else { return UITableViewCell() }
            cell.titleLbl.text = AppConstants.authLoginTitle
            cell.subtilteLbl.text = AppConstants.authLoginSubtitle
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthTextViewCell.self)) as? AuthTextViewCell else { return UITableViewCell() }
//            cell.titleLbl.text = AppConstants.authEmailLbl
//            cell.iconView.image = UIImage(named: IconName.email)
            cell.setBorderColor(isPrimaryColor: true)
            cell.setData(data: ListModel(title: AppConstants.authEmailLbl, image: IconName.email, hint: "Ex: abc@example.com"))
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthTextViewCell.self)) as? AuthTextViewCell else { return UITableViewCell() }
            cell.setBorderColor(isPrimaryColor: true)
            cell.inputTextField.isSecureTextEntry = true
            cell.setData(data: ListModel(title: "Your \(AppConstants.authPasswordLbl)", image: IconName.password, hint: "**********"))
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ForgetLblViewCell.self)) as? ForgetLblViewCell else { return UITableViewCell() }
            cell.forgetPassDelegate = self
            return cell
        case 4:
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

extension LoginVC: ForgetPasswordProtocol {
    func forgetPasswordNavigation() {
        self.navigateToViewController(storyboardName: Storyboard.auth.rawValue, viewControllerIdentifier: String(describing: ForgetPasswordVC.self), viewModel: BaseViewModel()) { (vc: ForgetPasswordVC, nil) in
            return vc
        }
    }
    
    
}
