//
//  PatientCustomModel.swift
//  AlopeciaAreaMeter
//
//  Created by Syed Mujtaba Hassan on 29/03/2024.
//

import Foundation


struct PatientModel {
    var name: String = ""
    var profileImg: String = ""
    
    init(name: String, profileImg: String) {
        self.name = name
        self.profileImg = profileImg
    }
}
