//
//  RecordViewCell.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 20/03/2024.
//

import UIKit

class RecordViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
    }
    
    func setView() {
        // Add shadow
//        mainView.layer.shadowColor = ColorConstants.subtitleColor.cgColor
//        mainView.layer.shadowOpacity = 0.5
//        mainView.layer.shadowOffset = CGSize(width: 0, height: 2)
//        mainView.layer.shadowRadius = 4
//
//           // Add corner radius
//        mainView?.layer.cornerRadius = 6
//        mainView?.layer.masksToBounds = true
//
//           // Add border
//        mainView?.layer.borderColor = ColorConstants.borderColor.cgColor
//        mainView?.layer.borderWidth = 1
        
        mainView.layer.cornerRadius = 6
        mainView.layer.shadowColor = ColorConstants.borderColor.cgColor
        mainView.layer.shadowOffset = CGSize(width: 0, height: 2)
        mainView.layer.shadowRadius = 6
        mainView.layer.shadowOpacity = 1.0
        mainView.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
