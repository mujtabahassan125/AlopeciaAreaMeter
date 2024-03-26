//
//  SignUpVC.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 20/03/2024.
//

import UIKit

class SignUpVC: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var authList = [ListModel]()
    var viewModel: SignUpVM?
    override func viewDidLoad() {
        super.viewDidLoad()
        populateSideMenuItems()
        registerNibs()

        // Do any additional setup after loading the view.
    }
    
    init?(coder: NSCoder, viewModel: SignUpVM) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func registerNibs() {
        tableView.register(UINib(nibName: String(describing: AuthTextViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AuthTextViewCell.self))
        tableView.register(UINib(nibName: String(describing: AuthHeaderViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AuthHeaderViewCell.self))
        tableView.register(UINib(nibName: String(describing: AuthBtnsViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AuthBtnsViewCell.self))
    }
    
    private func populateSideMenuItems() {
        
        authList.append(ListModel(title: AppConstants.authCreateAccount, image: "", hint: ""))
        authList.append(ListModel(title: AppConstants.authFirstNameLbl, image: IconName.userProfile, hint: "Ex:John"))
        authList.append(ListModel(title: AppConstants.authlastNameLbl, image: IconName.userProfile, hint: "Ex:Doe"))
        authList.append(ListModel(title: AppConstants.authPhoneLbl, image: IconName.phone, hint: "Ex: +44 7172 423"))
        authList.append(ListModel(title: AppConstants.authEmailLbl, image: IconName.email, hint: "Ex: abc@example.com"))
        authList.append(ListModel(title: AppConstants.authPasswordLbl, image: IconName.password, hint: "*******"))
        authList.append(ListModel(title: "", image: "", hint: ""))
        
    }
    

  

}

extension SignUpVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthHeaderViewCell.self)) as? AuthHeaderViewCell else { return UITableViewCell() }
            cell.headerLbl.text = AppConstants.authHeader
            cell.headerTitle.text = AppConstants.authCreateAccount
            return cell
        case 6:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthBtnsViewCell.self)) as? AuthBtnsViewCell else { return UITableViewCell() }
            cell.setDataForSignup()
            cell.authActionsDelegate = self
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthTextViewCell.self)) as? AuthTextViewCell else { return UITableViewCell() }
            let data = authList[indexPath.row]
            if data.title == AppConstants.authPasswordLbl {
                cell.inputTextField.isSecureTextEntry = true
            }
            cell.setData(data: data)
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension SignUpVC: AuthActionsProtocol {
    func authNavigation() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func authProccessing() {
        self.navigateToViewController(storyboardName: Storyboard.patient.rawValue, viewControllerIdentifier: String(describing: PatientHomeVC.self), viewModel: BaseViewModel()) { (vc: PatientHomeVC, nil) in
            return vc
        }
    }
    
    
}


