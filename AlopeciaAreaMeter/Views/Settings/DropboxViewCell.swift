//
//  DropboxViewCell.swift
//  AlopeciaAreaMeter
//
//  Created by Mujtaba Hassan on 08/04/2024.
//

import UIKit

class DropboxViewCell: UITableViewCell {

    @IBOutlet weak var settingsIcon: UIImageView!
    @IBOutlet weak var settingsLbl: UILabel!
    @IBOutlet weak var checkIcon: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellLabel(lblString: String, isCheckBox: Bool, iconImage: UIImage) {
        
        settingsLbl.text = lblString
        checkIcon.isHidden = !isCheckBox
        settingsIcon.image = iconImage
    }
    
}
