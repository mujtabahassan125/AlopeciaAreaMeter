//
//  RecordViewCell.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 20/03/2024.
//

import UIKit

class RecordViewCell: UITableViewCell {

    @IBOutlet weak var valueLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
    }
    
    func setView() {

        mainView.layer.cornerRadius = 6
        mainView.layer.shadowColor = ColorConstants.borderColor.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainView.layer.shadowRadius = 6
        mainView.layer.shadowOpacity = 1.0
        mainView.layer.masksToBounds = false
        
        
    }
    
    func setCellData(data: PatientRecordModel) {
        dateLbl.text = data.date
        valueLbl.text = "\(data.value) cm"
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
