//
//  LoginVC.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 18/03/2024.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var loginBtnView: UIView!
    
    @IBOutlet weak var registerLblView: UIView!
    @IBOutlet weak var continueWithGoogleView: UIView!
    @IBOutlet weak var sepratorView: UIView!
    var viewModel: LoginViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()

        registerNibs()
        loadCustomTableViewCell()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
      //  setButton()
    }
    
    private func registerNibs() {
        tableView.register(UINib(nibName: String(describing: AuthTextViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AuthTextViewCell.self))
        tableView.register(UINib(nibName: String(describing: AuthHeaderViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AuthHeaderViewCell.self))
        tableView.register(UINib(nibName: String(describing: MainBtnViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MainBtnViewCell.self))
    }
    
    init?(coder: NSCoder, viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setButton() {
        let nib = UINib(nibName: "MainBtnViewCell", bundle: nil)
        guard let mainBtnViewCell = nib.instantiate(withOwner: self, options: nil).first as? MainBtnViewCell else {
                  fatalError("Failed to load MainBtnViewCell from storyboard.")
              }
        loginBtnView.addSubview(mainBtnViewCell)
        
        mainBtnViewCell.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
    }
    
    private func loadCustomTableViewCell() {
        // Load the custom table view cell from the storyboard
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "MainBtnViewCell", bundle: bundle)
        if let customCell = nib.instantiate(withOwner: self, options: nil).first as? MainBtnViewCell {
            // Optionally configure your cell here
            // For example:
            // customCell.textLabel?.text = "Custom Cell Text"
    
            // Add the custom cell as a subview
            loginBtnView.addSubview(customCell)
            customCell.frame = loginBtnView.bounds
            
            continueWithGoogleView.addSubview(customCell)
            customCell.frame = continueWithGoogleView.bounds
            customCell.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
        
        
        
    }
}

extension LoginVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthHeaderViewCell.self)) as? AuthHeaderViewCell else { return UITableViewCell() }
            cell.headerLbl.text = "Login now to track all your expenses and income at a place!"
            cell.headerTitle.text = "Login"
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthTextViewCell.self)) as? AuthTextViewCell else { return UITableViewCell() }
            cell.titleLbl.text = "Email"
            cell.iconView.image = UIImage(named: "emailIcon")
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthTextViewCell.self)) as? AuthTextViewCell else { return UITableViewCell() }
            cell.titleLbl.text = "Your Password"
            cell.inputTextField.isSecureTextEntry = true
            cell.inputTextField.placeholder = "**********"
            cell.iconView.image = UIImage(named: "passwordIcon")
          
            return cell
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
