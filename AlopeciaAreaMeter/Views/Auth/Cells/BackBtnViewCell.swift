//
//  BackBtnViewCell.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 06/04/2024.
//

import UIKit

protocol BackBtnProtocol {
    func popViewContoller()
}

class BackBtnViewCell: UITableViewCell {
    var backBtnDelegate: BackBtnProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func backbtnAction(_ sender: Any) {
        backBtnDelegate?.popViewContoller()
    }
}
