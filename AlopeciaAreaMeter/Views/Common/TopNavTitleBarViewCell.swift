//
//  TopNavTitleBarViewCell.swift
//  AlopeciaAreaMeter
//
//  Created by Mujtaba Hassan on 08/04/2024.
//

import UIKit


protocol TopNavProtocol {
    func popViewContoller()
}

class TopNavTitleBarViewCell: UITableViewCell {
    
    var topNavTitleDelegate: TopNavProtocol?

    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func backBtnAction(_ sender: Any) {
        topNavTitleDelegate?.popViewContoller()
    }
    
    func setLabel(title: String) {
        titleLbl.text = title
    }
    
}
