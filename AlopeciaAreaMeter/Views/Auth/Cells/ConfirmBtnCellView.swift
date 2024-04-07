//
//  ConfirmBtnCellView.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 06/04/2024.
//

import UIKit

protocol ConfirmActionProtocol {
    func navigateToNextScreen()
}

class ConfirmBtnCellView: UITableViewCell {
    
    var confirmActionDelegate: ConfirmActionProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func confirmBtnAction(_ sender: Any) {
        confirmActionDelegate?.navigateToNextScreen()
    }
    
    
}
