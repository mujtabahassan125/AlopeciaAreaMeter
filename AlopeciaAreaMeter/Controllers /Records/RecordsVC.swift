//
//  RecordsVC.swift
//  AlopeciaAreaMeter
//
//  Created by Mujtaba Hassan on 26/03/2024.
//

import UIKit

class RecordsVC: UIViewController {

    @IBOutlet weak var sepratorView: UIView!
    @IBOutlet weak var navTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var navigationBarView: NavBarView!
    
    var patient: PatientModel?
    
    let records = [PatientRecordModel(date: "Friday, 15 March, 12:08 PM", value: 71.33), PatientRecordModel(date: "Thursday, 14 March, 01:08 PM", value: 71.33), PatientRecordModel(date: "Wednesday, 13 March, 12:08 PM", value: 71.33) ]
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        navTitle.text = patient?.name
        

    }
    
    private func registerNibs() {
        tableView.register(UINib(nibName: String(describing: RecordViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: RecordViewCell.self))
        tableView.register(UINib(nibName: String(describing: GraphViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: GraphViewCell.self))

    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func segmentValueChanged(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            self.tableView.reloadData()
        case 1:
            self.tableView.reloadData()
        default:
            break
        }
    }
}

extension RecordsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return records.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecordViewCell.self)) as? RecordViewCell else { return UITableViewCell() }
            sepratorView.isHidden = false
            cell.setView()
            cell.setCellData(data: records[indexPath.row])
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: GraphViewCell.self)) as? GraphViewCell else { return UITableViewCell() }
            sepratorView.isHidden = true
            cell.setupChart()
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return 300
        default:
            return UITableView.automaticDimension
        }
    }
}
