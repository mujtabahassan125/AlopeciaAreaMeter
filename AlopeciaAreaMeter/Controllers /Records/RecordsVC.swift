//
//  RecordsVC.swift
//  AlopeciaAreaMeter
//
//  Created by Mujtaba Hassan on 26/03/2024.
//

import UIKit

class RecordsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var navigationBarView: NavBarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarView.nameLbl.text = "John Smith"
        

    }
    
    private func registerNibs() {
        tableView.register(UINib(nibName: String(describing: RecordViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: RecordViewCell.self))

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
            return 0
        default:
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return 2
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch segmentControl.selectedSegmentIndex {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecordViewCell.self)) as? RecordViewCell else { return UITableViewCell() }
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       // return UITableView.automaticDimension
        return 85
    }
}
