//
//  SideMenuListViewCell.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 24/03/2024.
//

import UIKit

class SideMenuListViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellData(data: ListModel) {
        
        cellImage.image = UIImage(named: data.image)
        cellLabel.text = data.title
     //   cellLabel
    }
    
}
