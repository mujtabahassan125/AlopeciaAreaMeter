//
//  ForgetLblViewCell.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 06/04/2024.
//

import UIKit


protocol ForgetPasswordProtocol {
    func forgetPasswordNavigation()
}

class ForgetLblViewCell: UITableViewCell {
    
    var forgetPassDelegate: ForgetPasswordProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func forgetPasswordAction(_ sender: Any) {
        forgetPassDelegate?.forgetPasswordNavigation()
    }
}
