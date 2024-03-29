//
//  PatientHomeAlert.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 29/03/2024.
//

import UIKit

class PatientHomeAlertVC: UIViewController {

    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var patient: PatientModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()

    }
    
    private func registerNibs() {
        tableView.register(UINib(nibName: String(describing: AuthTextViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: AuthTextViewCell.self))
    }
    
    @IBAction func completeAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        
        self.dismiss(animated: true)
    }

}


extension PatientHomeAlertVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthTextViewCell.self)) as? AuthTextViewCell else { return UITableViewCell() }
            cell.setAlertData(name: patient?.firstName ?? "John", listData: ListModel(title: AppConstants.authFirstNameLbl, image: "", hint: ""))
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthTextViewCell.self)) as? AuthTextViewCell else { return UITableViewCell() }
            cell.setAlertData(name: patient?.lastName ?? "Doe", listData: ListModel(title: AppConstants.authlastNameLbl, image: "", hint: ""))
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
