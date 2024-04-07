//
//  VerifyOTPViewCell.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 06/04/2024.
//

import UIKit

class VerifyOTPViewCell: UITableViewCell {

    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var viewThree: UIView!
    @IBOutlet weak var viewFour: UIView!
    @IBOutlet weak var viewFive: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewStyling(view: viewOne)
        viewStyling(view: viewTwo)
        viewStyling(view: viewThree)
        viewStyling(view: viewFour)
        viewStyling(view: viewFive)
    }
    
    func viewStyling(view: UIView) {
        // Set border color of the view
        view.layer.borderColor = ColorConstants.greyColor.cgColor
        view.layer.borderWidth = 1.0 // You can adjust the width as needed
        view.layer.cornerRadius = 10.0 // You can adjust the corner radius as needed
    }
    
    
    
}
