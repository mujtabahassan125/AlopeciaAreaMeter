//
//  AuthViewCell.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 17/03/2024.
//

import UIKit

class AuthTextViewCell: UITableViewCell {

    @IBOutlet weak var InputView: UIView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
