//
//  CalculatedAreaAlertVC.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 29/03/2024.
//

import UIKit

class CalculatedAreaAlertVC: UIViewController {

    @IBOutlet weak var areaLbl: UILabel!
    
    var calculatedArea: Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        areaLbl.text = "Shape area is \(calculatedArea) cm²"
    }
    
    @IBAction func addAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

}
