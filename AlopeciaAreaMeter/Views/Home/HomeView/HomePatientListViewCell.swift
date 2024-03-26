//
//  HomePatientViewCell.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 20/03/2024.
//

import UIKit

class HomePatientListViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        mainView.layer.borderColor = UIColor.white.cgColor
        mainView.layer.borderWidth = 1.0 // You can adjust the width as needed
        mainView.layer.cornerRadius = 6.0 // You can adjust the corner radius as needed
    }
    
}
