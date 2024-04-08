//
//  ForgetPasswordVC.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 06/04/2024.
//

import UIKit

class ForgetPasswordVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
    }
    
    private func registerNibs() {
        tableView.register(UINib(nibName: String(describing: AuthTextViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AuthTextViewCell.self))
        tableView.register(UINib(nibName: String(describing: AuthHeaderViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AuthHeaderViewCell.self))
        tableView.register(UINib(nibName: String(describing: AuthBtnsViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AuthBtnsViewCell.self))
        tableView.register(UINib(nibName: String(describing: BackBtnViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: BackBtnViewCell.self))
        tableView.register(UINib(nibName: String(describing: ConfirmBtnCellView.self), bundle: nil), forCellReuseIdentifier: String(describing: ConfirmBtnCellView.self))
    }
    


}

extension ForgetPasswordVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BackBtnViewCell.self)) as? BackBtnViewCell else { return UITableViewCell() }
            cell.backBtnDelegate = self
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthHeaderViewCell.self)) as? AuthHeaderViewCell else { return UITableViewCell() }
            cell.titleLbl.text = AppConstants.forgetPassTitleText
            cell.subtilteLbl.text = AppConstants.forgetPassSubTitleText
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthTextViewCell.self)) as? AuthTextViewCell else { return UITableViewCell() }
            cell.setBorderColor(isPrimaryColor: false)
            cell.setData(data: ListModel(title: "Your \(AppConstants.authEmailLbl)", image: IconName.email, hint: "Ex: abc@example.com"))
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ConfirmBtnCellView.self)) as? ConfirmBtnCellView else { return UITableViewCell() }
            cell.confirmActionDelegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ForgetPasswordVC: ConfirmActionProtocol, BackBtnProtocol {
    func popViewContoller() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func navigateToNextScreen() {
        self.navigateToViewController(storyboardName: Storyboard.auth.rawValue, viewControllerIdentifier: String(describing: VerifyOtpVC.self), viewModel: BaseViewModel()) { (vc: VerifyOtpVC, nil) in
            return vc
        }
    }
    
}
