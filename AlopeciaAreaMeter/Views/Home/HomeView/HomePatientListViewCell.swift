//
//  HomePatientViewCell.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 20/03/2024.
//

import UIKit

class HomePatientListViewCell: UITableViewCell {


    
    @IBOutlet weak var imageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var mainView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setCellData(data: PatientModel) {
        
        nameLbl.text = data.name
        profileImgView.image = UIImage(named: data.profileImg)
        
//        if data.profileImg == IconName.dummy {
//            view.backgroundColor = .clear
//            imageViewHeightConstraint.constant = 42
//            imageViewWidthConstraint.constant = 42
//        } 
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainView.layer.borderColor = UIColor.white.cgColor
        mainView.layer.borderWidth = 1.0 // You can adjust the width as needed
        mainView.layer.cornerRadius = 6.0 // You can adjust the corner radius as needed
        
        let padding: CGFloat = 50.0
        
        // Adjust the frame to add padding
        profileImgView.frame = CGRect(x: profileImgView.frame.origin.x + padding,
                                      y: profileImgView.frame.origin.y + padding,
                                      width: profileImgView.frame.size.width - 2 * padding,
                                      height: profileImgView.frame.size.height - 2 * padding)
    }
    
    @IBAction func cameraAction(_ sender: Any) {
    }
    
    @IBAction func editAction(_ sender: Any) {
    }
    @IBAction func removeAction(_ sender: Any) {
    }
}
