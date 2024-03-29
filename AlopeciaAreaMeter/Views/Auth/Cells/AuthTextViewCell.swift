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
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set border color of the view
        InputView.layer.borderColor = ColorConstants.primary.cgColor
        InputView.layer.borderWidth = 1.0 // You can adjust the width as needed
        InputView.layer.cornerRadius = 6.0 // You can adjust the corner radius as needed
    }
    func setData(data: ListModel) {
        inputTextField.placeholder = data.hint
        titleLbl.text = data.title
        iconView.image = UIImage(named: data.image)
    }
    
    func setAlertData(name: String, listData: ListModel) {
        iconView.isHidden = true
        inputTextField.text = name
        
        titleLbl.text = listData.title
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
