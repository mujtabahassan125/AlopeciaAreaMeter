//
//  SignUpVC.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 20/03/2024.
//

import UIKit

class SignUpVC: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: SignUpVM?
    override func viewDidLoad() {
        super.viewDidLoad()

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
            cell.headerLbl.text = "Login now to track all your expenses and income at a place!"
            cell.headerTitle.text = "Create Account"
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthTextViewCell.self)) as? AuthTextViewCell else { return UITableViewCell() }
            cell.titleLbl.text = "First Name"
            cell.iconView.image = UIImage(named: "emailIcon")
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthTextViewCell.self)) as? AuthTextViewCell else { return UITableViewCell() }
            cell.titleLbl.text = "Last Name"
            cell.iconView.image = UIImage(named: "emailIcon")
            
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthTextViewCell.self)) as? AuthTextViewCell else { return UITableViewCell() }
            cell.titleLbl.text = "Phone"
            cell.iconView.image = UIImage(named: "emailIcon")
            
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthTextViewCell.self)) as? AuthTextViewCell else { return UITableViewCell() }
            cell.titleLbl.text = "Email"
            cell.iconView.image = UIImage(named: "emailIcon")
            
            return cell
        case 5:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthTextViewCell.self)) as? AuthTextViewCell else { return UITableViewCell() }
            cell.titleLbl.text = "Your Password"
            cell.inputTextField.isSecureTextEntry = true
            cell.inputTextField.placeholder = "**********"
            cell.iconView.image = UIImage(named: "passwordIcon")
          
            return cell
        case 6:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthBtnsViewCell.self)) as? AuthBtnsViewCell else { return UITableViewCell() }
            
            cell.loginBtn.setTitle("Register", for: .normal)
            cell.sepratorView.isHidden = true
            cell.bottomStack.isHidden = true
            cell.continueWithGoogleBtn.isHidden = true
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
   
